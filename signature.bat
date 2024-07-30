
set sign_file=%1
echo %sign_file%
"crutch/signtool" sign /v /as /fd sha1 /sha1 a0f3f8cf46dc7f832f2de7f02379b9c2dc884884 /tr http://timestamp.digicert.com /td sha256 %sign_file%/*.*
"crutch/signtool" sign /v /as /fd sha256 /sha1 a0f3f8cf46dc7f832f2de7f02379b9c2dc884884 /tr http://timestamp.digicert.com /td sha256 %sign_file%/*.*
