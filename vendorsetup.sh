for f in $(cat vendor/lucid/lucid.devices); do
    add_lunch_combo lucid_$f-userdebug;
done
