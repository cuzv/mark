# Audio Playback in iOS

Note in read [「Audio Playback in iOS」](http://msching.github.io/blog/2014/07/07/audio-in-ios/)

经典的音频播放流程（以MP3为例）

1. 读取MP3文件
2. 解析采样率、码率、时长等信息，分离MP3中的音频帧
3. 对分离出来的音频帧解码得到PCM数据
4. 对PCM数据进行音效处理（均衡器、混响器等，非必须）
5. 把PCM数据解码成音频信号
6. 把音频信号交给硬件播放
7. 重复1-6步直到播放完成

![](./AudioPlaybackIniOS.img/api-architectural-layers.png)

高层接口进行功能说明

- Audio File Services：读写音频数据，可以完成播放流程中的第2步；
- Audio File Stream Services：对音频进行解码，可以完成播放流程中的第2步；
- Audio Converter services：音频数据转换，可以完成播放流程中的第3步；
- Audio Processing Graph Services：音效处理模块，可以完成播放流程中的第4步；
- Audio Unit Services：播放音频数据：可以完成播放流程中的第5步、第6步；
- Extended Audio File Services：Audio File Services和Audio Converter services的结合体；
- AVAudioPlayer/AVPlayer(AVFoundation)：高级接口，可以完成整个音频播放的过程（包括本地文件和网络流播放，第4步除外）；
- Audio Queue Services：高级接口，可以进行录音和播放，可以完成播放流程中的第3、5、6步；
- OpenAL：用于游戏音频播放，暂不讨论

