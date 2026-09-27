# Check if the internet (e.g. Google/YouTube/Cloudflare) is reachable.
# Usage:
#   proxy_ok && echo "online" || echo "offline"
function proxy_ok --description "Check if proxy working"
  curl -fsI --connect-timeout 3 --max-time 5 -o /dev/null https://www.google.com; or \
  curl -fsI --connect-timeout 3 --max-time 5 -o /dev/null https://www.youtube.com; or \
  curl -fsI --connect-timeout 3 --max-time 5 -o /dev/null https://www.cloudflare.com
end
