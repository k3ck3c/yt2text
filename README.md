# yt2text
get the text of a Youtube Video using whisper or any AI tool
this script 
downloads only the audio of a Youtube vid
gives a filename without emoticon or space, using the author and the title of the video
sends the audio to whisper or any AI tool
creates a directory by YouTube author
puts the text in the directory

example 1
the command 

sh yt2text.sh "https://www.youtube.com/watch?v=xJCW_EJjkLg" jp w

we pass jp to help determine the language and avoid analysis of the first 30 seconds of audio to determine the language

we pass w as we want to use locally whisper

it creates a file 

MUSIC_Liverary/MUSIC_Liverary-HAJIME_CHITOSE_WADATSUMI_NO_KI_MUSIC_VIDEO_FULL.txt

which contains

Detecting language using up to the first 30 seconds. Use `--language` to specify the language

Detected language: Japanese

[00:00.000 --> 00:10.000] 作詞・作曲・編曲 初音ミク

[00:13.000 --> 00:26.000] 赤く 錆びた 月の夜に

[00:26.000 --> 00:40.000] 小さな船を浮かべましょう

[00:41.000 --> 00:51.000] 薄い透明な風は

[00:51.000 --> 01:09.000] 二人を 遠く 遠くに 流し 召した

[01:09.000 --> 01:23.000] どこまでも 真っ直ぐに 進んで

[01:23.000 --> 01:37.000] 同じところを ぐるぐる 回って

[01:37.000 --> 01:53.000] 星もない 暗闇で 彷徨う 二人が 歌う歌う

...


example 2

sh yt2text.sh "https://www.youtube.com/watch?v=zXO_j0vriwk" en

will create a file

Charles_Dowding/Charles_Dowding-No_dig_Potato_Gardening_-_Expert_Tips_from_Charles_Dowding.txt

which contains

{"text":"Growing potatoes without digging. How is it done? The ground preparation is exactly the same as for any other vegetable. You don't need to have a special bed for potatoes. 

You certainly don't need to dig a trench. So it's simply undisturbed soil in this case with mulch on top and my mulch is compost. So this is A few centimeters, maybe three, 

four centimeters of compost here that we put on last autumn after clearing leaks, which interestingly were following potatoes.

...
