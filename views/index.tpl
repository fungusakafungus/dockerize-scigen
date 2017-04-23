<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Output files</title>
    <link rel="stylesheet" href="style.css">
    <script src="script.js"></script>
  </head>
  <body>
    <code>
%for f in files:
	<a href="/savedir/{{f}}">/savedir/{{f}}</a><br>
%end
    </code>
  </body>
</html>
