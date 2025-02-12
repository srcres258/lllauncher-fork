# 有关Little Limbo Launcher插件板块的问答！

## 以下是Json插件示例：

- 1.0.0以及之后版本的插件示例：[点我](./MultiPlugins.md)

## 新的插件功能，DLL模块大更新！！

### Q：什么是DLL？

- A：DLL是为一个对于Windows上的动态链接库，这种动态链接库就相当于一个没有主函数的exe文件。主要是可以供其他的程序员对此dll里的函数进行调用的。

- 这里用通俗一点的话来说，QQ的exe可执行文件的大小为什么这么小？最多不超过几十MB？而QQ可执行文件的同级目录下却有一大堆的dll和一大堆的exe文件作为附属。而QQ本身自己从网上下载下来的文件就是一个安装包形式的exe文件。那么为什么QQ要包装成一个安装包形式供用户进行安装呢？原因很简单，QQ有太多的动态链接库【就是dll】需要调用了。为了极大地优化可执行文件exe的大小，它将一些必要的函数都封装进了dll里面。这就是dll文件的用途了！

- 那么用户用这些dll文件有什么用处呢？其实用处很简单。生活中无处不见的dll文件，早已深深的进入我们的内心，但凡用过电脑的同学，即使没有点开软件目录，也是见过部分软件的dll配套的吧。我们从网上下载的zip软件，其实也是解压即用的。里面就或多或少的附带了一些dll。这些dll都是供软件制造商自己调用的。包括我自己的Little Limbo Launcher一样，之前也用过Indy附属的两个dll，只是自从0.0.17版本以上就不再用了而已。dll本质上的目的，其实就是为了软件制造商简化制作流程而制作的一种格式文件。

### Q：那DLL文件应该如何调用呢？

- A：DLL文件里面，会有一些方法或者函数会被主程序调用。其中的返回值或许是int、void以及一堆东西。同样的，假如软件制造商开源了此软件，或者提出了一个接口可以供别的用户制造一些附属dll，那么用户也可以制作自己的dll插件进入软件中被调用。

- DLL里面分为这几种：第一：过程，也就是无返回值无参数的过程。这个是众多软件提供的接口类型，当用户自制的dll被软件读取之后，首先调用的必定是这个dll的主函数。相当于Java或者C#或者C/C++中的Main函数，具体主函数名是什么，还得看软件制造商的插件教程。这里不多说。

- 主函数可以是main函数，也可以是别的函数名，谁知道呢。。。

### Q：那应该如何制作LLL启动器的插件呢？

- A：哈哈，终于到达点子上了吗？好吧！既然这样的话，那我就直说了！
1. 首先，我们使用的编程语言是Delphi，当然，其他的语言没有试过，不过应该能被我的软件读取到的。这里只用Delphi作为示例，大家可以自己先看着。
2. 首先，进入我们的**Delphi**主界面【这里给个小提示，Delphi如果去官网下载的话是要收费的，建议大家去网上找破解版下载安装，安装过程不再赘述，但切记，安装的时候根据需求安装Windows-x64系统的编译。】，然后点击左上角**File**，然后有个**New**，这个是创建一个新的工程的意思，然后右侧选择**Dynamic Library**。这个的意思是动态链接库的意思。就是创建一个dll。
3. 然后创建工程完毕之后，不要担心，也别动其他位置，直接运行一次**Run**。此时会弹出一个**Error**。这个是必然的！我们仔细看这个**Error**的右侧几行字，有一个**Run|Parameters**，我们按照这个路径依次从菜单栏中找到**Run/Parameters**。
4. 找到参数之后，最上面有一个**Debug Configuration - XXX**的，此时我们就需要查看一些事情。众所周知，我的启动器分为**Windows-i686和Windows-X86_64**的，**一个32位系统，一个64位系统**。
5. 此时，我们先退出这个窗口【如果你本身就是32位系统，无法下载并加载64位系统的编译，那这一步可以跳过。】，然后在右侧的**ProjectGroup1**中，找到你的工程名字【默认**Project1**，事后可以进行修改。】。右键点击**Target Platforms**，然后有个**Add Platform**，在下拉框中选择**Windows 64Bit**，然后点击OK即可应用64位系统独享的插件。
6. 此时回到第四步，我们发现**Debug Configuration**可以选择**Windows 64Bit**了！然后我们再看到有一个**All Configuration**和**Debug Configuration**和**Release Configuration**，这三个分别代表了**【所有构建】【调试构建】【发布构建】**。其中，我们可以选中【调试构建】的**64-Bit**。然后就可以进行下一步了！
7. 调试构建的意思是，对你的dll程序进行调试，多半是用来测试bug的，可以进行打断点调试的操作【发布构建无法打断点】，发布构建的意思就是当你的dll文件已经做好了，准备打算发布了的时候，此时就应该换成发布构建。此构建方法是可以极大地压缩你的dll的体积大小。多半可以压缩3-4倍左右。
8. 选择好所有构建之后，仔细看下面的几行，第一个**Host Application**，这个的意思是主应用，意思就是你需要选择一个依托于此DLL运行的程序。这里直接选择我的启动器作为主应用就可以了。DLL不能够单独被运行，因此需要有一个“寄主”。
9. 下一个是**Parameters**，这个是程序运行的参数。我们都可以看到，有一部分软件需要调用某些参数才能够运行，拿一个简单的例子，我需要在cmd中运行shutdown关机，其中shutdown需要输入-s -t 1000才能够正常的执行关闭事件，那么-s -t 1000这三个就分别是shutdown的三个参数了，然后-a是取消关机计划，这也是一个参数。exe软件其实是可以有参数也可以没有参数的，具体需要看制造者的意图。但由于我的启动器并没有任何参数才能运行，因此这个空留空即可。
10. 下两个空完全不必管它，直接留空即可。具体想知道用途的，可以自行上网搜索，这里不多赘述。
11. 首先明确自己需要制造哪一个平台的插件，你是要做64位的还是32位的，又或者是两个都做【如果两个都做，你就要回到刚刚的**Run/Parameter**设置32或者64bit的可执行文件路径。其中路径一定要选择正确，不要选择了64结果却做32的。或者相反。】，然后在右侧的**Build Configuration和Target PlatForms**中灵活切换你需要制作的平台。可以随意换成**Debug**打断点，但是在运行之前，还得做一件事！那就是：调整dll文件的输出位置。
12. 调整dll文件的输出位置，由于我的启动器软件的插件部分，是放在 **{exe}/LLLauncher/plugins**下面的，因此，你需要调整输出位置，才能使我的程序正确的读取到你的dll文件。那么这个如何更改呢？我们在菜单栏中找到**Project**，然后在左侧中的**Building**下拉框中找到**Delphi Compiling**，上面依旧有一个**Target**，根据需要自己填入需要的平台。然后下面有一个**Output Directory**，这个是输出文件夹的意思，我们将其改到我们的 **{exe}/LLLauncher/plugins**之中，此时，就大功告成了！！！
13. 给大家一点点小提示，大家可以**下载四个LLL启动器，其中两个是64位的，还有两个是32位的。**，然后 **【以64位举例】其中一个exe可以用来进行断点调试、Debug插件。还有一个exe可以用来发布。**放心吧，Delphi里面的所有设置都是有一个Target供你选择构建平台的，因此无论怎么修改，构建产物dll都会随着构建平台的改变而改变。大家可以在右侧的两个选项卡中选择并应用即可。大家也可以不必要只选择【调试构建】，发布构建也可以选择啊！
14. 下面为我写的一个插件的示例，大家请看：

```pascal
library DllTest; //此文件为后缀时dpr后缀的文件，意思就是主文件。所有有关的代码都在这个文件中运行主要函数。library的意思是库。

uses //使用一些Windows专属类库。
  Winapi.Windows,
  Vcl.Forms,
  System.SysUtils,
  System.Classes //DLL附属里面无需写入implementation。

begin //直接在begin里面写即可，无需写入任何主函数。
  messagebox(Application.Handle, '这是一个测试插件的Log', '测试插件', MB_ICONINFORMATION); //此处为一个信息框调用示例。
end.
```

16. 目前由于Delphi的某些局限性，因此暂不发布有关Linux或者MacOS运行的方法。等我以后有钱了，买了一台Mac电脑再说。【求求大家发个电吧！】
17. 具体Delphi教程我不会教的，大家自己上网搜索看。如果大家实在是不懂得此Delphi编程的话，可以使用别的语言进行编写。但由于我没有试过别的任何一门语言，因此我暂时不会提供教程。例如C#，我就不会！
18. 如果实在不懂得编程的话，那么此部分插件教程您可以忽略，您可以直接去做json的插件，这玩意我还没有删除，并且json插件也不确定以后会不会常常更新【只要反馈得多了，总会更新的。】，大致上就这么多。
19. 如果大家使用别的语言进行编写，那么【也许，我估计是】只用写一个main函数，然后在main函数里面写逻辑就好了，无需写入任何方法体。
哦，对了，如果大家使用Dll创建的插件，在主窗口设置的任何颜色、主题、图标等在此dll插件中均不会实现，因此，如果想要应用主应用的父背景颜色，除了使用json作为插件以外，这里倒是没有任何一点点办法。也的确没有一点点办法。大家自求多福吧！

- 作者发布了一个示例插件，大家可以去查看一下，点击底部插件市场，

### Q：如何辨别来路不明的Dll插件？

- A：很简单，不下载来路不明的dll插件。由于dll插件内部由二进制代码构成，因此无法直接查看dll源码。因此，除非原作者开源，否则建议大家先去虚拟机里面运行一次，然后才能在实体机上运行。在安全性这一方面，作者始终是没有任何办法解决，只能全心全意的对用户们说一定要小心那些来路不明的插件，这个由敲代码组成的插件，实现的功能简直可以比json插件多了不知道哪里去了！因此，别怪我没提醒你们，一定要慎重！慎重！再慎重！

### Q：如果我的电脑被不明插件攻击了，个人信息全部被上传到插件作者的服务器上，启动器作者应该负责吗？

- A：这点来说，启动器作者是不会负责的，因为上一点我已经说得很明白了，不要轻易下载来路不明的插件。这里打个警告啊：
- 如果但凡出现了使用本启动器而电脑被不明插件攻击的事件，作者一概不负责。这种事例目前在我身上没发现，但是在别的软件中已经发现了有人恶意发布不明dll，而导致用户电脑受损的事例，因此这里不再赘述。启动器作者一概不负责用户电脑被攻击的危险。

### Q：Dll插件有没有插件市场呢？

- A：有的！但你必须具备以下几个条件，方可将你的插件发布到我的github的插件市场中。否则你只能私下传播。
1. 此插件必须开源，而且Readme必须要有作者的运行截图。Readme中必须具体介绍你的插件使用用途。开源网址必须具备issue问题提交。【当然，下载链接也是必要的。】
2. 此插件不可以隐含对用户电脑造成任何损害的代码，例如直接格式化硬盘。【这个无法被检测到，因此不作数。作者自己也不敢运行来历不明的插件。】
3. 此插件的作者必须加入内测群。【为什么要有这个规定？以防止有部分用户在使用插件时电脑被攻击时我能帮此用户讨论说法。】
4. 你的插件每次更新一个版本，都必须首先将最新版本的运行截图在Readme中发出来。即使没有运行截图，也必须让我在虚拟机中实际运行一次你的dll，否则我怕你传到开源网址中的代码是一副德行，传到蓝奏云的dll是另一幅德行。
5. 所有的插件必须在开源网址中。如果需要发布，请按照标准格式对着我的github上的issue反馈区进行投稿Dll插件。

- 下面介绍一下如何发布自己的插件。作者的QQ群中一概不接受任何Dll形式的插件上传，如果你非要将自己的dll插件发布到插件市场，必须将插件源码公开到任何一个仓库，然后作者会去审核你的源代码，再将你的蓝奏云下载链接贴在Readme最显眼的位置，我将在虚拟机中实际运行一次你的dll插件，如果实测没问题了，我再将你的dll文件上传到我的插件市场当中。

- 再说个前提，dll发布可以遵循大家直接在github以issue的形式发布，告诉我你的开源网址，然后具体实现功能。然后在issue中贴出你在内测群中的QQ号，我会单独审问你一些问题，如果你都答对了，我才会发布你的插件【具体问多少个问题看作者心情。】。如果必要，你还得上传你每次插件的更新日志。

- 发布之后的问题：待我审核通过之后，会将你的issue根据自己的格式发布到PluginMarket中，插件市场的官网请看启动器内部的官网一栏。接着你就慢慢等待作者更新官网吧！

### Q：如何应用Dll插件？

- A：直接将dll插件放入**{exe}/LLLauncher/Plugins**文件夹就好了。json插件也是如此。应用时启动器的插件菜单栏会有显示【**你的插件名称.你的插件后缀**】，后缀可以是dll，也可以是json，但是不能是别的！。

### Q：插件可不可以使用一些非Windows原生库的部分功能？例如Indy附属才能实现的？或者一些界面库之类的？

- A：是可以的，但是你必须保证用户能够正常运行你的插件，并且需要在开源网址中的Readme中介绍清楚你的插件。需要哪些附属Dll，需要放在【C:/Windows】下还是放在【C:/Windows/System32】下，又或者是【exe本目录】下。等等等等。需要哪些附属dll，一切的一切你都可以使用。

### Q：如何写出美丽又美好的插件？

- A：首先，你必须得怀着一颗善良的心，其次就是一个学习的心，再者就是一个审美的心。【第一个是防止你做出恶意插件，第二个是让你能够有学习编程的劲，第三个是你设计的窗口可以很美，不像我的主窗口那么丑。】

### Q：作者后期有什么打算么？

- A：没有什么打算。。。修修启动器的bug等等、、为插件系统提供更加多种多样的效果。
- **大家如果有任何bug反馈，或者任何新功能建议，都可以和我提出哦！**
- 但是Dll这一部分的插件我是再也不会修改了的，因为就是调用一个Delphi内置函数读取主方法的过程，除非是你要求我修改主方法的识别名称，否则一切免谈。json倒是可以接受一下反馈。因为这玩意我还没移除，就是为了让那些不会编程的人们能够感受制作插件的快乐。

### 插件市场：[点我进入](https://gitcode.net/rechalow/lllauncher/-/blob/master/credits/PluginMarket.md)