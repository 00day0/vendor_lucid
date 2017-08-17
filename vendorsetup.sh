for combo in $(curl -s https://raw.githubusercontent.com/OzoneOS/hudson/master/ozone-build-targets | sed -e 's/#.*$//' | grep ozone-15.0 | awk '{printf "ozone_%s-%s\n", $1, $2}')
do
    add_lunch_combo $combo
done
