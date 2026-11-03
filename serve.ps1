$root = Split-Path -Parent $MyInvocation.MyCommand.Path
$port = 8123
$listener = New-Object System.Net.HttpListener
$listener.Prefixes.Add("http://localhost:$port/")
$listener.Start()
Write-Host "Sirviendo $root en http://localhost:$port/ (Ctrl+C para parar)"

$mime = @{
  ".html"="text/html; charset=utf-8"; ".htm"="text/html; charset=utf-8"
  ".css"="text/css"; ".js"="application/javascript"
  ".jpg"="image/jpeg"; ".jpeg"="image/jpeg"; ".png"="image/png"; ".gif"="image/gif"; ".svg"="image/svg+xml"
  ".pdf"="application/pdf"; ".mp4"="video/mp4"; ".json"="application/json"; ".ico"="image/x-icon"
}

while ($listener.IsListening) {
  $ctx = $listener.GetContext()
  $req = $ctx.Request
  $res = $ctx.Response
  try {
    $path = $req.Url.AbsolutePath
    if ($path -eq "/") { $path = "/prototipo-pedidos.html" }
    $filePath = Join-Path $root ($path.TrimStart("/") -replace "/", "\")

    if (Test-Path $filePath -PathType Leaf) {
      $ext = [System.IO.Path]::GetExtension($filePath).ToLower()
      $contentType = $mime[$ext]
      if (-not $contentType) { $contentType = "application/octet-stream" }
      $res.ContentType = $contentType
      $bytes = [System.IO.File]::ReadAllBytes($filePath)

      $range = $req.Headers["Range"]
      if ($range -and $range.StartsWith("bytes=")) {
        $parts = $range.Substring(6).Split("-")
        $start = [int]$parts[0]
        $end = if ($parts[1]) { [int]$parts[1] } else { $bytes.Length - 1 }
        $len = $end - $start + 1
        $res.StatusCode = 206
        $res.Headers.Add("Content-Range", "bytes $start-$end/$($bytes.Length)")
        $res.ContentLength64 = $len
        $res.OutputStream.Write($bytes, $start, $len)
      } else {
        $res.ContentLength64 = $bytes.Length
        $res.OutputStream.Write($bytes, 0, $bytes.Length)
      }
    } else {
      $res.StatusCode = 404
      $msg = [System.Text.Encoding]::UTF8.GetBytes("404 Not Found: $path")
      $res.OutputStream.Write($msg, 0, $msg.Length)
    }
  } catch {
    try { $res.StatusCode = 500 } catch {}
  } finally {
    $res.OutputStream.Close()
  }
}
