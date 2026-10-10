# poweroff after stopping some services
#   usage: sudo tidy_poweroff

set SERVICES_TO_STOP "daed" "dae"

function _stop_services_before_poweroff
  for service in $SERVICES_TO_STOP
    echo "stopping services: $service"
    systemctl stop "$service" 2>/dev/null
  end
end

function tidy_poweroff --description "poweroff after stopping some services"
  _stop_services_before_poweroff
  systemctl poweroff
end


