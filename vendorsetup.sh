for f in $(cat vendor/ozone/ozone.devices); do
    add_lunch_combo ozone_$f-userdebug;
done
