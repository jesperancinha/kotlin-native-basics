b:
	~/.konan/kotlin-native-*/bin/cinterop  -def stdio.def -o stdio.klib
	~/.konan/kotlin-native-*/bin/konanc  main.kt -o puts -library stdio.klib
install:
	sudo apt update
	sudo apt install build-essential clang
pipeline:
	/snap/bin/cinterop  -def stdio.def -o stdio.klib
	/snap/bin/konanc  main.kt -o puts -library stdio.klib
