![robot](img/robot.png)

# bangalter
sync music to your Android device better

## Usage
```
./bangalter.rb -i ~/Music/local -o /sdcard/Music -c 320k
```

## Dependencies
- `adb` installed and in your path (with debug settings enable on your device)
- `ffmpeg` with libvorbis installed and in your path

## Planned functionality
Script will:
- Measure source folder size and compare to available storage space remaining on device
- Estimate output of all songs compressed at bitrate C, compare to available storage space remaining on device
- Reencode to ogg with bitrate C and push individual files, as to not "double" disk space necessary
- If no transcode specified, adb push the entire folder
- Internal storage only