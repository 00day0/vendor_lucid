for f in $(cat vendor/fi/fi.devices); do
    add_lunch_combo fi_$f-userdebug;
done
