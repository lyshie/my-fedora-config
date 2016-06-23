# Prints the 'fan speed', 'CPU governor' and 'CPU frequency'.

run_segment() {
	local now_timestamp=$(date +%s)
	local n=$(expr $now_timestamp % 9)

	case "$n" in
		"0" | "1" | "2") # Fan Speed
			#echo -n "✼ ";
			acpitool -f | grep -PZo "(?<=:\s)\d+\s*RPM"
			;;
		"3" | "4" | "5") # CPU Governor
			cpupower frequency-info  | grep -PZo "(?<=The governor \").+(?=\")"
			;;
		"6" | "7" | "8") # CPU Frequency
			cpupower frequency-info  | grep -PZo "(?<=current CPU frequency is ).+(?=\.)"
			;;
	esac

	return 0
}
