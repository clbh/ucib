case "${OPTS[arch]}" in
	"amd64") kernel="linux-image-amd64";;
	"i386")  kernel="linux-image-686";;
	*)       fatal "Unknown architecture: ${OPTS[arch]}"
esac

if ! debootstrap  \
           --arch "${OPTS[arch]}" \
           --include "udev,openssh-server,locales,sudo,${kernel},grub-pc" \
           --exclude "dmidecode" \
           wheezy \
           "$TARGET" \
           "${OPTS[debootstrap-mirror]}" |& \
               tee "${TARGET}/debootstrap_output" |
               spin "Running debootstrap"; then
	error "Debootstrap failed:"
	cat "${TARGET}/debootstrap_output"
	exit 1
fi