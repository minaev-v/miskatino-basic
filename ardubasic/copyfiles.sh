cp ../core/*.c .
for f in *.c; do mv "$f" "${f%.c}.ino"; done
cp ../core/*.h .