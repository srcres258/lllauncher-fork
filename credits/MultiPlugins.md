# 有关LLL1.0.0新版的json插件写法：

## 以下是json文件的提示：

### 如何写出一个漂亮的插件？

- 你可能需要一个有审美的心理，控制好页面的布局。

### 有没有一个插件的示例？

- 有的！请看下面：

```json
{
	"plugin_name": "my_plugin_name",
	"plugin_author": "my_plugin_author",
	"plugin_update_time": "my_plugin_update_time",
	"plugin_description": "my_plugin_description",
	"plugin_version": "my_plugin_version",
	"form_caption": "插件在Tabsheet中的名称显示！",
	"form_show": [
		
	],
	"form_close": [
		
	],
	"content": [
		{
			"type": "button",
			"name": "my_local_button_name_1",
			"caption": "测试按钮1",
			"font_color": "#cbcbcb",
			"font_size": 18,
			"font_style": "等线",
			"hint": "将鼠标移到我上面可以看到提示哦！如果enabled为false的话，on_click里面的不会执行，同时该提示信息也不会显示哦！",
			"position": [0,0,50,50],
			"on_click": [
				{
					"type": "messagebox",
					"title": "这是信息框的标题",
					"context": "这里是自定义信息框按钮文字，当然也有内置按钮文字，例如【ok|yes|no|cancal|retry|abort|ignore】，这里最多只能使用4个按钮。\n当然，第一个yes按钮总是在最右边，而第二个no按钮则是在倒数第二个位置。以此类推。color也有四个值，分别为【pass（绿色）、warning（黄色）、error（红色）、information（蓝色），颜色值也是可以输入RGB的！】",
					"color": "warning",
					"button": [
						"yes",
						"no",
						"This is Test!"
					],
					"result": "my_custom_value"
				},
				{
					"if": {
						"my_custom_value": 1,
						"type": "messagebox",
						"title": "来点小提示1！",
						"context": "这里写当按下yes时执行的shell语法\n这里的my_custom_value指的是按下第几个按钮。依然是按照从右往左的顺序。例如按下了yes按钮则返回值是1。\n如果未指定color或者button属性，则默认color是information，且button默认只有一个[ok]。\n如果不定义result，则默认忽略返回值！\n如果该if语句里没有【变量】:【值】，则默认这个if将一直为false。。"
					},
					"else": {
						"if": {
							"my_custom_value": 2,
							"type": "messagebox",
							"title": "来点小提示2！",
							"context": "这里写当按下no时执行的shell语法\n如果有两个或以上的信息框，则可以定义一大堆的type，一大堆的result变量，你甚至可以以此写一个视觉小说！\n你甚至可以在这里的result定义，然后后期再点击其他的按钮时触发！\n如果定义了result，但是没有定义button，则默认返回值永远都是1！因为只有一个默认button为ok……\n如果叉掉信息框，则默认该返回值为0，也就是说你可能需要判断返回值为0的情况（如果返回值变量与其他控件变量冲突了，则会共享一个变量，且不会发生任何报错哦！",
							"button": [
								"yes",
								"no"
							],
							"result": "i_love_you"
						},
						"else": {
							"type": "messagebox",
							"title": "来点小提示3！",
							"context": "这里写当按下第三个按钮时执行的shell语法，如果有第四个按钮，这里也照常运行。\n如果if语句写在前面，并且里面没有值，则直接报错。else则是当信息框不满足点击返回值时才执行。既然有type，则可以直接执行任何一串指定的语句！一个on_click中的一个代码块里只能有一个if-else。。并且有了if-else之后将不能再有其他的代码块！否则将忽略，当然仅有if也是可以的！",
						}
					}
				}
			]
		},
		{
			"type": "image",
			"name": "my_local_image_name_1",
			"caption": "测试图片1",
			"hint": "将鼠标移到我上面可以看到提示哦！",
			"image":{
				"path": ".\\LLLauncher\\BackgroundImage\\something.png",
				"suffix": "png"
			},
			"position": [58,0,50,50],
			"on_click": [
				{
					"type": "messagebox",
					"title": "另一个测试",
					"context": "再说一点有关上面信息框的吧，首先if-else每个这样的块只能执行一次，不能连续执行。这个我感到万分的悲伤。。也就是说如果你需要做一个视觉小说这种连续性很强的话，能得在on_click里面写上一大堆的if-else语句了（【并且if-else一次只能判断一个值！所以如果你有两个或以上的值要判定的话也不行。】【if-else还能判定输入框里的值，不过这个我们后说！】"
				},
				{
					"type": "messagebox",
					"title": "另一个测试",
					"context": "上面介绍完了信息框，下面就该介绍图片框和了。图片框里含有一个image字样，里面可以有三种键值。分别是【base64、path、url】，其中优先级为从左到右。程序会首先判定你的键值里是否有base64字样，如果有的话，则直接会忽略掉你的path和url键值，无论你的base64放在哪。因此我建议只填入一个键值即可。image甚至可以当作按钮使用！如果该代码块里没有image字样，则该图片全部透明，无法显示！如果该图片加载不出来【例如base64错误、path找不到图片、url读取不到】，则图片默认什么也不会显示……其中吼，我建议各位是将position的width和height给弄成与图片分辨率一致的，否则会有点难看的（"
				}
			]
		},
		{
			"type": "label",
			"name": "my_local_label_name_1",
			"caption": "测试标签1",
			"hint": "这是一个标签噢！你还是可以将鼠标移到我上面看到提示……这个标签也可以有on_click属性……",
			"font_style": "微软雅黑",
			"font_size": 20,
			"font_color": "#0000FF",
			"back_color": "#FF0000",
			"position": [0,58,50,50],
			"on_click": [
				{
					"type": "messagebox",
					"title": "标签1的提示",
					"context": "可以看到，这个标签控件与别的控件都大不相同，这是因为该控件有一个back_color属性！这个属性可以指定该标签控件的背景色！也就是说，该标签可以以蓝色为背景色，红色为文字的颜色。其长宽可以通过position属性来修改！"
				}
			],
			"on_mousemove": [
				{
					"type": "change",
					"name": "my_local_label_name_1",
					"font_color": "#00FF00"
				}
			],
			"on_mouseleave": [
				{
					"type": "change",
					"name": "my_local_label_name_1",
					"font_color": "#0000FF"
				}
			]
		},
		{
			"type": "button",
			"name": "my_local_button_name_2",
			"caption": "这是暂时不可点击的按钮！",
			"hint": "现在可以被点击了！因为你可以看得见我了！",
			"enabled": false,
			"visible": true,
			"font_style": "黑体",
			"font_size": 20,
			"font_color": "#111111",
			"position": [58,58,50,50],
			"on_click": [
				{
					"type": "messagebox",
					"title": "你似乎可以点我了呢！",
					"context": "好吧，既然你已经能点我了！那我就来介绍一下控件的基本属性吧！首先是类型。类型有很多种控件类型，上述我们已经看到过【label、button、image】了，下面我们还会看见更多控件类型！然后是name，name是一个唯一的统一标识符！用于描述这个控件本身的属性。你可以理解成玩家看不见，但是隐藏的表示。刚刚的type为change的代码块已经很好的解释了这种情况。然后name是所有控件的唯一标识符，这也就意味着你无法为多个控件设置同样的name！！【切记这一点！】"
				},
				{
					"type": "messagebox",
					"title": "下一个提示。。。",
					"context": "然后是caption，这个只有部分控件才有。。例如按钮、标签。这个属性用来显示该控件上的文字。然后是enabled属性，这个属性刚刚也看到了，这个控件本身其实是不可以点击原因就在它的enabled是false，如果该属性不填的话，则默认为true。然后是visible，这个控件的意思是控制该按钮是否能显示在窗口上。如果为false，你就看不见也点不了啦！如果该属性不填的话，则默认为true。然后是hint，这个的意思就是在enabled和visible都为true的情况下，当鼠标停在上面时显示提示。默认为空。"
				},
				{
					"type": "messagebox",
					"title": "下下一个提示。。。",
					"context": "然后是font家族，这个也只有部分控件才有，有caption的，或者有特定值的控件才有！这个的意思是描述该控件的文字长什么样。例如font_style控制该字体样式，默认为宋体。font_size为字号，默认为9，font_color为字体颜色。默认为000000纯黑。font_color也有一些常用颜色，例如red、yellow、black、green、blue等。具体在下面会说。"
				},
				{
					"type": "messagebox",
					"title": "下下一个提示。。。",
					"context": "随后是position属性，这个属性用来描述该控件的位置，缺一不可！缺了一个就报错！多了会忽略。【第1个值为Left，也就是该控件距离左侧的位置。第2个值为Top，也就是该控件距离顶侧的位置。第3个值为Width，也就是该控件的宽度。第4个值为Height，也就是该控件的高度。】，最后嘛，就是事件属性啦！第一个是【on_click】，这个属性用于控制该控件点击事件！，还有一个是【on_mousemove】，这个是当鼠标滑动到该控件上时执行，一般写change。。最后一个是【on_mouseleave】，该事件是鼠标移出该控件时执行。谁会在里面写messagebox啊喂！"
				}
			]
		},
		{
			"type": "button",
			"name": "my_local_button_name_3",
			"caption": "点我将按钮解锁",
			"hint": "点我可以将该窗口中的按钮解锁！",
			"font_style": "黑体",
			"font_size": 20,
			"font_color": "#111111",
			"position": [0,116,50,50],
			"on_click": [
				{
					"type": "messagebox",
					"title": "点我解锁了！",
					"context": "你现在解锁了上面未解锁的按钮！同时我也将介绍一下change事件执行。change可以修改该窗口中的某一个控件的属性！例如我将把上面未解锁的按钮的enabled属性设置为【true】，现在它就可以点击了！然后change属性不仅可以修改enabled，caption、font_style、hint甚至直接修改on_click、on_mousemove等事件，甚至你还可以给该控件凭空生成一个属性！例如该控件本身是没有hint的，但是你给它change了一个hint！其实，当你写change的时候，里面的name值要与该控件的name值要一致，否则程序会找不到该name，从而修改失败！"
				},
				{
					"type": "change",
					"name": "my_local_button_name_2",
					"enabled": true
				}
			]
		},
		{
			"type": "edit",
			"name": "my_local_edit_name_1",
			"texthint": "这个是输入框的提示信息",
			"hint": "这个是鼠标移到上面的提示，如果下面的readonly属性为true，则该输入框不可修改！",
			"text": "这个是默认文本",
			"readonly": false,
			"font_style": "微软雅黑",
			"font_size": 9,
			"font_color": "#000000",
			"position": [0,174,100,23],
			"result": "my_edit_result"
		},
		{
			"type": "button",
			"name": "my_local_button_name_4",
			"caption": "点我可以按照输入框内的文本进行判断输出。",
			"hint": "点我输出噢！如果文本框内容不为空的话！",
			"font_style": "黑体",
			"font_size": 18,
			"font_color": "#101010",
			"position": [58,116,50,50],
			"on_click": [
				{
					"if":{
						"my_edit_result": "",
						"type": "inputbox",
						"title": "你的值为空呢！",
						"context": "你的值为空，所以你现在要自己输入一个值来为该控件的返回值赋值！同时这也是输入框的示例噢！如果输入框的信息为空的话，则你信息也为空噢！同时这也算作变量共享的示例。",
						"color": "error",
						"result": "my_edit_result"
					}
				}
				{
					"if":{
						"my_edit_result": "",
						"type": "messagebox",
						"title": "为什么你的值还是空啊！",
						"context": "好了，现在你来说说看，我刚刚让你输入一个值，为什么现在那个值还是空呢？",
						"color": "error",
					},
					"else":{
						"type": "messagebox",
						"title": "输入了值噢！",
						"context": "你刚刚输入了值，我无法判断你到底是在没输入值的情况下输入了值，还是已经在输入框里输入过值……但是也好，下面我将使用change来将输入框的值设置为你刚刚输入的值！也就是说，如果你想看到inputbox的话，就暂时不要输入下面的框啦！\n哦对了，如果想要在信息框里插入变量，我们可以用美元符号+大括号包住这个变量名，就像这样：${my_edit_result}，甚至是change里面也可以这么输入！\n好了，下面我来介绍一下readonly属性，这个属性标识着该编辑框是否可以被编辑，如果为true，则不可以。如果为false，则可以！默认为false！"
					}
				},
				{
					"type": "change",
					"name": "my_local_edit_name_1",
					"text": "${my_edit_result}"
				}
			]
		},
		{
			"type": "combobox",
			"name": "my_local_combobox_name_1",
			"hint": "一个下拉框控件示例呢！",
			"font_style": "黑体",
			"font_size": 18,
			"font_color": "#101010",
			"position": [0,205,100,23],
			"items": [
				"你好世界",
				"我爱你",
				"Hello World!",
				"I Love you!"
			],
			"itemindex": 0,
			"on_change": [
				{
					"type": "messagebox",
					"title": "你修改了该下拉框呢！",
					"context": "其实，on_change这个事件也是可以作用在edit中的捏！因为编辑框也是可以被修改的！这个事件的意思其实就是当控件某项属性被修改时！这个修改后的index索引值将会保存在result变量中。但是很遗憾，并没有保存【文本内容】的变量捏！然后，该下拉框也是可以定义on_click、on_mousemove、on_mouseleave等事件！最后一点，除了下拉框、滑动条以及我下面说过的一些控件以外，只有部分控件支持on_change事件！\n然后这里面有个itemindex，这个指的是该控件的默认值！就像窗口一出现，这个元素就默认定位到0号元素！【也就是1号“你好世界”啦！但是在程序里是0号……】"
				}
			],
			"result": "my_combobox_result"
		},
		{
			"type": "scrollbar",
			"name": "my_local_scrollbar_name_1",
			"hint": "这个是滑动条控件示例呢！其中min和max和current我觉得大家都应该懂是什么意思吧！记住，这个区间是左闭右闭的，不想Python那种左闭右开，这个确实是左闭右闭。。也就是min和max都包含进去了（",
			"position": [0, 236, 100, 23],
			"min": 10,
			"max": 100,
			"current": 30,
			"on_change": [
				{
					"type": "change",
					"name": "my_local_label_name_2",
					"caption": "滑动条滑动：${my_scrollbar_result}"
				}
			],
			"result": "my_scrollbar_result"
		},
		{
			"type": "label",
			"name": "my_local_label_name_2",
			"caption": "滑动条滑动：0",
			"hint": "这个是滑动条改变该数据值的示例！我觉得我不需要信息框你也应该懂的！",
			"position": [0, 267, 100, 20]
		},
		{
			"type": "memo",
			"name": "my_local_memo_name_1",
			"hint": "这是一个多行的编辑框捏！",
			"position": [58, 292, 50, 50],
			"font_style": "微软雅黑",
			"font_size": 9,
			"font_color": "#000000",
			"result": "my_memo_result",
			"lines": [
				"这里是默认行哟！",
				"这个Memo框已经打开了两种滑动条，既可以上下滑，也可以左右滑！",
				"多行编辑框也可以设置readonly属性！"
			]
		},
		{
			"type": "speedbutton",
			"name": "my_local_speedbutton_name_1",
			"caption": "这个是有图片背景的按钮示例哦。",
			"hint": "speedbutton是一个很神奇的按钮，它可以在文字的前面绘制一个图片！",
			"font_style": "黑体",
			"font_size": 18,
			"font_color": "#101010",
			"position": [0, 292, 50, 50],
			"image": {
				"path": ".\\LLLauncher\\BackgroundImage\\something.png",
				"suffix": "png"
			},
			"on_click": [
				{
					"type": "messagebox",
					"title": "介绍事件的内部执行",
					"context": "好了，接下来我将借这个按钮来和大家说明一下事件内部的执行。首先，我们各位可以看到：我们事件内部写的type，有messagebox、有change，也甚至有inputbox。那么我们可以试想一下，如果我点击这个按钮可以执行一行shell语法呢？又或者是操控LLL做一些事情呢？其实非常简单！下面我就用一些实际示例来给大家说明一下！"
				},
				{
					"type": "shell",
					"implement": [
						"explorer.exe https://www.afdian.net/a/Rechalow"
					]
				},
				{
					"type": "shell",
					"implement": [
						"notepad.exe .\\LLLauncher\\configs\\LittleLimboLauncher.ini"
					]
				},
				{
					"type": "shell",
					"implement": [
						"mspaint.exe .\\LLLauncher\\BackgroundImage\\something.png"
					]
				},
				{
					"type": "copy",
					"value": "将本文本复制进剪切板，当然也可以使用变量！${my_memo_result}"
				},
				{
					"type": "song",
					"song": {
						"path": ".\\LLLauncher\\BackgroundMusic\\something.mp3",
						"suffix": "mp3"
					}
				},
				{
					"type": "memory_free"
				},
				{
					"type": "random",
					"min": 1,
					"max": 10,
					"result": "my_random_result"
				},
				{
					"type": "switch_page",
					"page": 3
				}
			]
		}
	]
}
```

### 插件作者有没有需要注意的地方？

1. 好了，上面就是我们的插件所有的示例了！想必各位能看得懂吧！各位可以将其复制到一个json文件，然后放在LLLauncher\Plugins文件夹目录下噢！
2. 上述最后一个speedbutton里，我在on_click事件里写了许多执行语句，但是在真正要执行的时候，我是非常不建议各位写这么多语句的（一般来说，写一个语句，然后用一个Messagebox来阻止线程继续运行，然后再来一个语句。。
3. 然后嘛，如果该插件内部含有了【form_show】或者是【form_close】事件中的任意一个，就是但凡有这个键，值肯定是列表，那将无法运行最后一个speedbutton中的【switch_page】执行语句。将会直接忽略不计！因此上述的插件的最后一个switch_page事件其实并不会直接执行。。。
4. 这个switch_page事件，其实是按照该程序主界面的PageControl上面的页索引来的，比如说示例中写的是3，实际上会被传送到【下载部分】！因为主界面的索引是0，而下载部分的索引是3！如果超出了索引，则按下这个按钮则立即弹出报错提示！
5. 然后在form_show和form_close事件中，其实close事件本意是指当切出这个page时执行该语句，所以close事件中将无法执行【change】类型，然后show语句中其实也不允许执行【change】，因为插件一旦被生成所有控件都是固定的。因此show和close事件里只能执行shell、memory-free、messagebox等语句，这两个事件肯定是无法执行【switch_page】的，因为有了这两个事件中的任意一个，该语句都会被忽略！
6. 上述有个song，这个song键值其实也是可以填入path、url、base64的！然后点击即可调用主界面的TMediaPlayer控件进行播放！这个事件也可以放到【form_show】、【form_close】事件中执行！然后就只能去背景设置去停止播放了！
7. 最后还有一点：那就是插件嵌套了！这个我没写到插件里，因为这个在form_show、form_close有任一事件时也不能执行！具体语法如下：

```json
{
	"type": "open",
	"json": {
		"path": ".\\LLLauncher\\Plugins\\something.json",
		"suffix": "json"
	}
}
```

8. 这个open类型，是放在按钮或者别的一些事件里的！其中，json键值则表示的是另外一个插件地址。然后，该程序便会试图跳转到该插件的地址上。然后以一个新的tabsheet去显示该插件。同时两个插件都会显示在PageControl里！
9. 还有一个memory_free属性，这个属性可能会要求玩家用管理员启动程序！用于释放内存！
10. 上述所有事件都几乎可以使用enabled和visible属性，但是readonly只有Memo和Edit可以用……别的不能用，否则会忽略！在我的程序里，但凡只要遇到一个不符合标准的键值，则直接忽略不计！
11. 目前整个插件应用窗口里内嵌了【ScrollBox】，因此根本不必担心控件放不下，因为可以拉窗体哦！
12. 如果你在某一个信息框或者某一个事件里，使用了美元符号-大括号的形式引用了某个变量，但是**这个变量不存在于常量池种**，这个变量会被替换为空值。也就是说依然会被替换，但是会替换成空罢了（
13. 上述，我们甚至还定义了一个random命令，用于生成随机数！min代表了最小值，max代表了最大值！
14. 其中，如果有换页效果的，例如open和switch_page，那么这个必须得是按钮的最后一个点击事件类型，因为执行到这个的时候，下面的所有过程都将忽略了！【因为此时已经换页了，再保留下列的就没意思了（反正也不会执行到……】
15. 如果你想在程序一开始的时候，就直接读取一个插件，可以试试这样：

```json
{
	"url": "https://www.example.com/test.json",
	"suffix": "json"
}

```

16. 其中，这里面也同样可以填入base64、url和path的标准输出。是的，你甚至可以直接在插件里导向至别的地方！
17. 话说回来，是谁说json插件的变量只接收【数字】的呢？字符串也是可以哒！
18. 我妥协了（既然如此，那么各位在导入base64编码的文件时，需要指定文件后缀。像下面的示例：

```json
{
	"image": {
		"base64": "XXXXXXX",
		"suffix": "png"
	}
}
```

19. 当然，如果你想要转到别的插件的时候，使用base64的话，则也需要指定文件扩展名为【json】，否则直接报错哟！当然，**如果里面填入的是【path、url】的话，也需要指定后缀哟！**
20. 目前图片暂不支持【gif】后缀的动态图。
21. 啊，对了！在插件里的suffix和base64、url、path等，其实也是接受变量的。但是我们可以使用一个专用的on_click或者是form_show里的函数来主动定义变量。参见下面演示：

```json
{
	"on_click": [
		{
			"type": "variable",
			"value": 114514,
			"result": "my_value"
		}
		{
			"if":{
				"my_value": "114514",
				"type": "messagebox",
				"title": "这种事情怎么能不叫我呢！",
				"context": "你触发了${my_value}条警告！程序即将崩溃！",
				"color": "error"
			}
		}
	]
}
```
22. 实际上，除了type和name以外，所有的属性几乎都可以使用变量。并且在程序中，变量都是按照【字符串】形式存的。因此无论你写的是【数字】还是【字符串】，最终效果都是一样的！在使用时我们可以直接使用${my_value}来直接使用变量。

### 那我应该怎样才能应用插件呢？

- 很简单，在启动启动器的时候，会在exe目录下生成一个plugins的文件夹，大家可以把自己写好的插件**随便命名，名称决定了窗口内显示的名称，但是后缀必须是json**然后放在plugins文件夹下，然后重启一次启动器，就可以应用插件了！

### 插件应用时窗口会有什么提示么？

- 插件应用的时候，会在`主窗口/插件/<你给插件命名的json名称>`出现。如果插件内容要是有一点点的错误，插件系统会自动提示有错误，需要修改。

### 启动器有没有插件市场呢？

- 你完全可以加进我的内测群，然后给你的插件命名一个美美的名字，然后传文件到我的QQ群文件的`插件`文件夹下。你也可以传进蓝奏云网盘，然后给你的同伴使用。当然，你还可以提出一个issue，记得用你的蓝奏云网盘提出一个链接就好了，然后我**作者**就会检查你的文件Shell语法是否含有病毒什么之类的，如果做得好，我会将你的插件打包到我的github上面。第三种是最优先的选法。

### 插件使用者有没有需要注意的地方？

- 首先，在版本中，Shell语法有着很强大的功能，稍有不慎可能就会很麻烦。我无法给你提供任何保障措施。所以，需要注意的地方你得看你编写的插件是否强大。请注意，如果你下载了来路不明的插件，你必须得仔细的咨询原作者。这样才行。
- 至目前为止，插件已有完整的写错预警，即使你的插件写错了，例如alpha属性不小心写成了256或者更高，或者127或更低，那么在程序中则会默认将其当做255处理。是的，即使插件写错也再也不用担心无法启动插件功能了。
- 当然，当你的【必须属性】一旦写错，那也将会不可避免的出现报错警告然后退出程序。这时无可避免的。但是【可选属性】就可以有报错中和。
- 然后，插件的编码格式默认为UTF-8。其次，我们会发现Memo的文字其实是可以被复制的！这也就意味着你们可以在Memo里面新增一些自己的一些网址什么之类的。都随意吧，反正不伤害到作者的权利就行了。Memo的Height和Width一定要符合你的文字长宽哦，这里是没有autosize的。当然，memo控件，默认是有ReadOnly的，也就是只读属性，不可修改。但是为了保障玩家只能够复制，我不能使其能够被修改。必须的。

### 插件的Shell语法到底可以执行什么功能呢？

- 很多功能，你可以直接在里面输入java指令，然后编译一个Java字节码文件。或者输入python，执行你的python脚本，或者一些别的语言。你甚至可以用C/C++在**EXE同目录**下编写一个源文件，然后用Shell语法直接执行。总之能实现的功能有很多了，主要取决与你到底会多少Shell语法，你甚至可以弄个定时关机的程序。就设置Caption为`多长时间关机`，然后在Shell里面写shotdown就可以了。
- 你甚至可以用来自制一个启动脚本，每次启动游戏的时候，启动脚本都会输出到EXE目录下，你可以把启动脚本复制粘贴到Button的按钮on_click上，然后你就可以在插件界面自主启动游戏了。是不是很方便？？但这个似乎只能自己用呢！因为你永远也不知道别人的启动路径在哪，不过似乎可以用相对路径代替哦！
- 在我们这个插件系统中，你甚至可以一边开着窗口一边对json进行调试，都是可以的，只需要退出一次插件窗口就可以了。无需重新点进exe。

### 目前实现的功能有哪些呢？

- 不少的功能了，足够你们先暂时使用了，剩下的后期我可能才会更新了。。。
- 上述示例我已经向大家展示了所有的功能，如果我的任何一个插件功能有任何的更新，我会第一时间更新这个界面的。下面介绍了各个控件属性的意义。
- 下列控件均按照子过程的type来定！如果默认值为**无**的话，则这个值为必须填入的值！如果为**空**，则默认是留空的！

#### 控件：

|控件名称|控件属性|属性功能|默认值|
|----|----|----|----|
|button|name|定义所有控件唯一标识符|无|
|button|caption|定义按钮显示文字|空|
|button|hint|定义按钮浮动提示文字|空|
|button|font_style|定义按钮文字样式|宋体|
|button|font_color|定义按钮文字颜色|black|
|button|font_size|定义按钮文字大小|9|
|button|enabled|是否可用|true|
|button|visible|是否可见|true|
|button|position|列表，四个值【0：距离窗口顶部，1：距离窗口左侧，2：控件宽度，3：控件高度】|无|
|button|on_click|列表，点击事件，详见（事件）|空|
|button|on_mousemove|列表，鼠标移上事件，详见（事件）|空|
|button|on_mouseleave|列表，鼠标移走事件，详见（事件）|空|
|label|name|定义所有控件唯一标识符|无|
|label|caption|定义标签显示名字|空|
|label|hint|定义按钮浮动提示文字|空|
|label|font_style|定义标签文字样式|宋体|
|label|font_color|定义标签文字颜色|black|
|label|font_size|定义标签文字大小|9|
|label|back_color|定义标签背景色|#F0F0F0|
|label|enabled|是否可用|true|
|label|visible|是否可见|true|
|label|position|列表，四个值【0：距离窗口顶部，1：距离窗口左侧，2：控件宽度，3：控件高度】|无|
|label|on_click|列表，点击事件，详见（事件）|空|
|label|on_mousemove|列表，鼠标移上事件，详见（事件）|空|
|label|on_mouseleave|列表，鼠标移走事件，详见（事件）|空|
|image|name|定义所有控件唯一标识符|无|
|image|hint|定义图片浮动提示文字|空|
|image|enabled|是否可用|true|
|image|visible|是否可见|true|
|image|position|列表，四个值【0：距离窗口顶部，1：距离窗口左侧，2：控件宽度，3：控件高度】|无|
|image|image|对象，见（标准输出）一栏|空|
|image|on_click|列表，点击事件，详见（事件）|空|
|image|on_mousemove|列表，鼠标移上事件，详见（事件）|空|
|image|on_mouseleave|列表，鼠标移走事件，详见（事件）|空|
|edit|name|定义所有控件唯一标识符|无|
|edit|texthint|定义编辑框的提示文字|空|
|edit|hint|定义编辑框的浮动提示文字|空|
|edit|text|定义编辑框的默认文本|空|
|edit|readonly|定义编辑框的是否仅可读|false|
|edit|font_style|定义编辑框文字样式|宋体|
|edit|font_color|定义编辑框文字颜色|black|
|edit|font_size|定义编辑框文字大小|9|
|edit|enabled|是否可用|true|
|edit|visible|是否可见|true|
|edit|position|列表，四个值【0：距离窗口顶部，1：距离窗口左侧，2：控件宽度，3：控件高度】|无|
|edit|on_click|列表，点击事件，详见（事件）|空|
|edit|on_mousemove|列表，鼠标移上事件，详见（事件）|空|
|edit|on_mouseleave|列表，鼠标移走事件，详见（事件）|空|
|edit|on_change|列表，内容修改事件，详见（事件）|空|
|edit|result|文字返回值，存入变量池中|空|
|combobox|name|定义所有控件唯一标识符|无|
|combobox|hint|定义下拉框浮动提示文字|空|
|combobox|font_style|定义下拉框文字样式|宋体|
|combobox|font_color|定义下拉框文字颜色|black|
|combobox|font_size|定义下拉框文字大小|9|
|combobox|enabled|是否可用|true|
|combobox|visible|是否可见|true|
|combobox|position|列表，四个值【0：距离窗口顶部，1：距离窗口左侧，2：控件宽度，3：控件高度】|无|
|combobox|item|列表，定义下拉框里的元素|空|
|combobox|itemindex|定义此时下拉框里的元素索引|-1|
|combobox|on_click|列表，点击事件，详见（事件）|空|
|combobox|on_mousemove|列表，鼠标移上事件，详见（事件）|空|
|combobox|on_mouseleave|列表，鼠标移走事件，详见（事件）|空|
|combobox|on_change|列表，内容修改事件，详见（事件）|空|
|combobox|result|下拉框的索引返回值，存入变量池中|空|
|scrollbar|name|定义所有控件唯一标识符|无|
|scrollbar|hint|定义滑动条浮动提示文字|空|
|scrollbar|enabled|是否可用|true|
|scrollbar|visible|是否可见|true|
|scrollbar|position|列表，四个值【0：距离窗口顶部，1：距离窗口左侧，2：控件宽度，3：控件高度】|无|
|scrollbar|min|滑动条最小值|0|
|scrollbar|max|滑动条最大值|100|
|scrollbar|current|滑动条当前值，最大最小值为左闭右闭规则|min|
|scrollbar|on_click|列表，点击事件，详见（事件）|空|
|scrollbar|on_mousemove|列表，鼠标移上事件，详见（事件）|空|
|scrollbar|on_mouseleave|列表，鼠标移走事件，详见（事件）|空|
|scrollbar|on_change|列表，内容修改事件，详见（事件）|空|
|scrollbar|result|返回当前数值|空|
|memo|name|定义所有控件唯一标识符|无|
|memo|hint|定义多行编辑框浮动提示文字|空|
|memo|position|列表，四个值【0：距离窗口顶部，1：距离窗口左侧，2：控件宽度，3：控件高度】|无|
|memo|font_style|定义多行编辑框文字样式|宋体|
|memo|font_color|定义多行编辑框文字颜色|black|
|memo|font_size|定义多行编辑框文字大小|9|
|memo|enabled|是否可用|true|
|memo|visible|是否可见|true|
|memo|readonly|定义多行编辑框的是否仅可读|false|
|memo|lines|定义默认显示文本|空|
|memo|on_click|列表，点击事件，详见（事件）|空|
|memo|on_mousemove|列表，鼠标移上事件，详见（事件）|空|
|memo|on_mouseleave|列表，鼠标移走事件，详见（事件）|空|
|memo|on_change|列表，内容修改事件，详见（事件）|空|
|speedbutton|name|定义所有控件唯一标识符|无|
|speedbutton|caption|定义按钮显示文字|空|
|speedbutton|hint|定义按钮浮动提示文字|空|
|speedbutton|font_style|定义按钮文字样式|宋体|
|speedbutton|font_color|定义按钮文字颜色|black|
|speedbutton|font_size|定义按钮文字大小|9|
|speedbutton|enabled|是否可用|true|
|speedbutton|visible|是否可见|true|
|speedbutton|image|对象，见（标准输出）一栏|空|
|speedbutton|position|列表，四个值【0：距离窗口顶部，1：距离窗口左侧，2：控件宽度，3：控件高度】|无|
|speedbutton|on_click|列表，点击事件，详见（事件）|空|
|speedbutton|on_mousemove|列表，鼠标移上事件，详见（事件）|空|
|speedbutton|on_mouseleave|列表，鼠标移走事件，详见（事件）|空|

#### 事件：

|事件类型|事件属性|事件功能|事件默认值|
|----|----|----|----|
|messagebox|title|定义信息框标题|空|
|messagebox|context|定义信息框文本|空|
|messagebox|color|定义信息框颜色，可以用16进制RGB，也可以【参见（颜色默认值）】。|information|
|messagebox|button|定义信息框按钮文字。可以使用自定义文字，也可以【参见（文字默认值），最多有4个按钮。】|yes|
|messagebox|result|定义信息框返回值，最多能返回到4。可空|空|
|change|name|需要改变的控件名称|无|
|change|剩下的|需要改哪个控件的属性就改|可以全空|
|shell|implement|执行的shell语句，是个列表，每次执行一行。|键不可空，列表可空|
|copy|value|要复制的文字|空|
|song|song|对象，见（标准输出）一栏|无|
|memory_free|暂无|直接强制清理内存|无|
|random|min|随机数最小值|0|
|random|max|随机数最大值|100|
|random|result|随机数返回值，左闭右闭区间|无|
|switch_page|page|数值，跳转到总窗口的界面的索引，例如主界面是0，版本设置是7|无|
|open|json|对象，见（标准输出）一栏|空|

- 其中，上面的部分事件，类似于messagebox、change、copy、shell等一堆事件，都可以使用（${变量名}）来获取到变量值。

#### 下面是部分不兼容的事件处理办法：

|事件名称|事件属性|处理办法|
|form_show|switch_page|只要出现了该属性，一律忽略|
|form_show|open|只要出现了该属性，一律忽略|
|form_close|以上属性|与上述处理方法一致|
|事件总支|switch_page|只能出现在按钮点击的最后一个事件，在此以下的所有过程均被忽略|
|事件总支|open|只能出现在按钮点击的最后一个事件，在此以下的所有过程均被忽略|

#### 标准输出：

|键|值|
|----|----|
|path|路径，可以是绝对路径也可以是相对exe的路径|
|url|可以是网址，但是仅支持http和https，不支持ftp等|
|base64|可以是一个base64编码后的文件。记住！【图片】默认当作png处理、【音乐】默认当作mp3处理、【插件】默认当作json处理。暂不支持别的种类的base64编码。|

#### 颜色默认值：

|属性名称|键名称|键值|
|messagebox|warning|rgb(255, 215, 10)|
|messagebox|information|rgb(10, 10, 255)|
|messagebox|error|rgb(255, 10, 10)|
|messagebox|pass|rgb(10, 192, 10)|
|text|blue|rgb(10, 10, 255)|
|text|red|rgb(255, 10, 10)|
|text|green|rgb(10, 255, 10)|
|text|black|rgb(10, 10, 10)|
|text|white|rgb(255, 255, 255)|

#### 文字默认值

|属性名称|键名称|键值|
|messagebox|yes|Language-messagebox_button_yes.caption|
|messagebox|no|Language-messagebox_button_no.caption|
|messagebox|ok|Language-messagebox_button_ok.caption|
|messagebox|cancal|Language-messagebox_button_cancel.caption|
|messagebox|ignore|Language-messagebox_button_ignore.caption|
|messagebox|retry|Language-messagebox_button_retry.caption|
|messagebox|abort|Language-messagebox_button_abort.caption|

#### 事件中的if-else

1. 这个我要单独拿出来讲一下，首先，对于if语句块，可以当作总事件触发器。一旦if出现在事件里面，则里面则必须含有一个【变量名】:【值】的这么一个键值，如果没有，或者变量池里找不到该变量，或者值不符合预期，则该if语句默认为false。讲自动查询该事件下是否含有else。
2. 如果含有else，则执行else里面的语句。同样的，else里面的语句也能够当作一个总事件触发器来实现。变量名可以通过很多种方式获取。其中，只需要定义一个result，则始终可以将该事件或者该控件的变量值赋给这个result，并且将该变量导入进变量池【其实变量池本质上是一个Dictionary。。】
3. 说完变量的获取，如果说在if-else以下，又出现了一个事件触发器，也就是有type值，则默认直接忽略。程序会首先查询该总事件触发器里面是否包含if。哪怕你的if是以键值形式，或者以任意一个不标准的形式出现，都会使得该事件触发器失效，然后立刻查询if语句下的变量名是否与变量值相等。

#### 有关random事件的详解

1. 这个random事件，其实不仅是能够作用在信息框和一些使用变量的字符串量里面嵌入的，它还可以直接修改属性，甚至是在form_show函数中，直接使用定义一个该变量，然后将其作用在【控件字体大小】、【控件宽高】等属性上。我们只需要这样做即可：

```json
{
	"type": "button",
	"name": "my_local_button_name_5",
	"position": ["${my_random_result}", "${my_random_result}", "${my_random_result}", "${my_random_result}"],
	"font_size": "${my_random_result}",
	"on_click": [
		{
			"if": {
				"my_random_result": 5,
				"type": "messagebox",
				"title": "随机数！",
				"context": "随机数生成是5！"
			}
		},
		{
			"type": "switch_page",
			"page": "${my_random_result}"
		}
	]
}
```
2. 可以看见，random变量存起来其实是一个字符串，但是使用的时候，却可以将其当成int来使用！但是如果要当作int来使用的话，只能将其单独作为一个变量，周围不能加入任何一个字符！否则会直接报错！

#### 有关form_show和form_close事件详解：

1. 在插件刚刚显示的时候，是不能使用信息框的！同时也不能使用任何可能导致窗口锁住的控件。比如说【内存清理】，当然了【switch_page】和【open】是绝对不能出现在上述两个事件中的！

#### 有关窗口默认属性

|属性键|属性介绍|是否必须|
|----|----|----|
|plugin_name|该插件总名字|必须|
|plugin_author|该插件作者|非必须|
|plugin_description|该插件简介|非必须|
|plugin_update_time|该插件更新时间|非必须|
|plugin_version|该插件版本号|非必须|
|form_caption|该插件标题|非必须|
|form_show|插件显示事件|非必须|
|form_close|插件关闭事件|非必须|
|content|插件总控件列表|必须|

- 上述只有两个是必须的，那就是插件总名字，这也算是一个默认唯一标识符之一，所有控件都不可以与该窗口的name重合。
- 然后第二个就是content，这个是和很神奇的东西！即使你窗体上一个控件也没有，也必须写这个代码块哦！

### 将来还会有更新吗？

- 目前总共更新了8个控件，也许未来会更新更多控件呢（也说不定呀（欢迎各位给我提出issue！！
- 已经爆更了……将来很长一段时间我都不想碰这玩意了（