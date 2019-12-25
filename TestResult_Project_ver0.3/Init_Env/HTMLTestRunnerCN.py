#coding=utf-8

import os
import re

"""
A TestRunner for use with the Python unit testing framework. It
generates a HTML report to show the result at a glance.
The simplest way to use this is to invoke its main method. E.g.
    import unittest
    import HTMLTestRunner
    ... define your tests ...
    if __name__ == '__main__':
        HTMLTestRunner.main()
For more customization options, instantiates a HTMLTestRunner object.
HTMLTestRunner is a counterpart to unittest's TextTestRunner. E.g.
    # output to a file
    fp = file('my_report.html', 'wb')
    runner = HTMLTestRunner.HTMLTestRunner(
                stream=fp,
                title='My unit test',
                description='This demonstrates the report output by HTMLTestRunner.'
                )
    # Use an external stylesheet.
    # See the Template_mixin class for more customizable options
    runner.STYLESHEET_TMPL = '<link rel="stylesheet" href="my_stylesheet.css" type="text/css">'
    # run the test
    runner.run(my_test_suite)
------------------------------------------------------------------------
Copyright (c) 2004-2007, Wai Yip Tung
Copyright (c) 2017, Findyou
All rights reserved.
Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are
met:
* Redistributions of source code must retain the above copyright notice,
  this list of conditions and the following disclaimer.
* Redistributions in binary form must reproduce the above copyright
  notice, this list of conditions and the following disclaimer in the
  documentation and/or other materials provided with the distribution.
* Neither the name Wai Yip Tung nor the names of its contributors may be
  used to endorse or promote products derived from this software without
  specific prior written permission.
THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER
OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
"""
 
# URL: http://tungwaiyip.info/software/HTMLTestRunner.html
 
__author__ = "Wai Yip Tung,  Findyou"
__version__ = "0.8.3"
 
 
"""
Change History
Version 0.8.3 -Findyou 20171206
* BUG fixed :错误的测试用例没有统计与显示
* BUG fixed :当PASS的测试用例有print内容时，通过按钮显示为红色
* 表格背景颜色根据用例结果显示颜色，优先级： 错误(黄色)>失败(红色)>通过(绿色)
* 合并文为HTMLTestRunner*N.py 同时支持python2,python3
Version 0.8.2.2 -Findyou
* HTMLTestRunnerEN.py 支持 python3.x
* HTMLTestRunnerEN.py 支持 python2.x
Version 0.8.2.1 -Findyou
* 支持中文，汉化
* 调整样式，美化（需要连入网络，使用的百度的Bootstrap.js）
* 增加 通过分类显示、测试人员、通过率的展示
* 优化“详细”与“收起”状态的变换
* 增加返回顶部的锚点
Version 0.8.2
* Show output inline instead of popup window (Viorel Lupu).
Version in 0.8.1
* Validated XHTML (Wolfgang Borgert).
* Added description of test classes and test cases.
Version in 0.8.0
* Define Template_mixin class for customization.
* Workaround a IE 6 bug that it does not treat <script> block as CDATA.
Version in 0.7.1
* Back port to Python 2.3 (Frank Horowitz).
* Fix missing scroll bars in detail log (Podi).
"""
 
# TODO: color stderr
# TODO: simplify javascript using ,ore than 1 class in the class attribute?
 
import datetime
try:
    from StringIO import StringIO
except ImportError:
    from io import StringIO
import sys
import time
import unittest
from xml.sax import saxutils
 
try:
    reload(sys)
    sys.setdefaultencoding('utf-8')
except NameError:
    pass
 
import ConfigParser

#防止自动将ini文件中的键名转换成小写
class myconf(ConfigParser.ConfigParser):
    def __init__(self,defaults=None):
        ConfigParser.ConfigParser.__init__(self,defaults=None)
    def optionxform(self, optionstr):
        return optionstr

TestcasePath='/data/'

#为解决测试用例名称与#9803标准不一致的情况，
#例如docker_namespace_pid,但python中不允许横线，只能是docker_namespace_pid
#因此，需要进行转换，
#文件TestCaseRelation.file存储了所有测试用例名称的对应关系，
#如果程序找不到某测试用例名，就查找这个关联文件进行查找
def getTransferKeyName(inputName):

    TestCaseFile='TestCaseRelation.file'
    TestCasePath = TestcasePath + '/' + TestCaseFile
    fr = open(TestCasePath,'r')
    dic = {}
    keys = []
    for line in fr:
        v = line.strip().split(':')
        dic[v[0]] = v[1]
        keys.append(v[0])
    fr.close()
    outputName = dic[inputName]
    #print('======================================')
    #print(outputName)
    #print('======================================')

    return outputName


def getGroupNumByName(TestType,keyName):

    GroupIniFile='TestcaseGroup_' + TestType +'.ini'
    TestcaseGroupPath = TestcasePath + str(TestType) +  '/' + GroupIniFile
    #config = ConfigParser.ConfigParser()
    config = myconf()
    config.readfp(open(TestcaseGroupPath))
    sectionName='GroupNum'
    #判断:如果存在找不到的情况，需要将"_"修改为"-"
    if not config.has_option(sectionName,keyName):
       #tmpKeyName = keyName.replace("_","-")
       #keyName = tmpKeyName
       keyName = getTransferKeyName(keyName)
    Num=config.get(sectionName,keyName)
    return Num

ResultPath='/data/'
IPListIniFile='ip_list.ini'
IPListIniFileName='ip_list'

def get_IP(TestType,Platform,TestCase,NodeNum):

    ip_list_path = ResultPath + str(TestType) + '/' + str(Platform) + '/' + IPListIniFile
    #config = ConfigParser.ConfigParser()
    config = myconf()
    #print os.getcwd() #获取当前工作目录路径

    config.readfp(open(ip_list_path))
    Group_num=getGroupNumByName(TestType,TestCase)
    tmp='获取的小组编号:' + Group_num
    #print tmp
    sectionName='Group'+ str(Group_num)
    keyName='ip_'+ str(NodeNum)
    resultStr=config.get(sectionName,keyName)
    retCode=resultStr
    return retCode


# ------------------------------------------------------------------------
# The redirectors below are used to capture output during testing. Output
# sent to sys.stdout and sys.stderr are automatically captured. However
# in some cases sys.stdout is already cached before HTMLTestRunner is
# invoked (e.g. calling logging.basicConfig). In order to capture those
# output, use the redirectors for the cached stream.
#
# e.g.
#   >>> logging.basicConfig(stream=HTMLTestRunner.stdout_redirector)
#   >>>
 
class OutputRedirector(object):
    """ Wrapper to redirect stdout or stderr """
    def __init__(self, fp):
        self.fp = fp
 
    def write(self, s):
        self.fp.write(s)
 
    def writelines(self, lines):
        self.fp.writelines(lines)
 
    def flush(self):
        self.fp.flush()
 
stdout_redirector = OutputRedirector(sys.stdout)
stderr_redirector = OutputRedirector(sys.stderr)
 
# ----------------------------------------------------------------------
# Template
 
class Template_mixin(object):
    """
    Define a HTML template for report customerization and generation.
    Overall structure of an HTML report
    HTML
    +------------------------+
    |<html>                  |
    |  <head>                |
    |                        |
    |   STYLESHEET           |
    |   +----------------+   |
    |   |                |   |
    |   +----------------+   |
    |                        |
    |  </head>               |
    |                        |
    |  <body>                |
    |                        |
    |   HEADING              |
    |   +----------------+   |
    |   |                |   |
    |   +----------------+   |
    |                        |
    |   REPORT               |
    |   +----------------+   |
    |   |                |   |
    |   +----------------+   |
    |                        |
    |   ENDING               |
    |   +----------------+   |
    |   |                |   |
    |   +----------------+   |
    |                        |
    |  </body>               |
    |</html>                 |
    +------------------------+
    """
 
    STATUS = {
    0: '通过',
    1: '失败',
    2: '错误',
    }
 
    DEFAULT_TITLE = '测试报告'
    DEFAULT_DESCRIPTION = ''
    DEFAULT_PLATFORM='Unknown'
    #DEFAULT_TESTER='Unknown'
    DEFAULT_TYPE='Unknown'
 
    # ------------------------------------------------------------------------
    # HTML Template
 
    HTML_TMPL = r"""<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>%(title)s</title>
    <meta name="generator" content="%(generator)s"/>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <link href="http://libs.baidu.com/bootstrap/3.0.3/css/bootstrap.min.css" rel="stylesheet">
    <script src="http://libs.baidu.com/jquery/2.0.0/jquery.min.js"></script>
    <script src="http://libs.baidu.com/bootstrap/3.0.3/js/bootstrap.min.js"></script>
    %(stylesheet)s
</head>
<body >
%(heading)s
%(report)s
%(ending)s
<script language="javascript" type="text/javascript">
output_list = Array();
// 修改按钮颜色显示错误问题 --Findyou v0.8.2.3
$("button[id^='btn_pt']").addClass("btn btn-success");
$("button[id^='btn_ft']").addClass("btn btn-danger");
$("button[id^='btn_et']").addClass("btn btn-warning");
/*level
增加分类并调整，增加error按钮事件 --Findyou v0.8.2.3
0:Pass    //pt none, ft hiddenRow, et hiddenRow
1:Failed  //pt hiddenRow, ft none, et hiddenRow
2:Error    //pt hiddenRow, ft hiddenRow, et none
3:All     //pt none, ft none, et none
4:Summary //all hiddenRow
*/
//add Error button event --Findyou v0.8.2.3
function showCase(level) {
    trs = document.getElementsByTagName("tr");
    for (var i = 0; i < trs.length; i++) {
        tr = trs[i];
        id = tr.id;
        if (id.substr(0,2) == 'ft') {
            if (level == 0 || level == 2 || level == 4 ) {
                tr.className = 'hiddenRow';
            }
            else {
                tr.className = '';
            }
        }
        if (id.substr(0,2) == 'pt') {
            if (level == 1 || level == 2 || level == 4) {
                tr.className = 'hiddenRow';
            }
            else {
                tr.className = '';
            }
        }
        if (id.substr(0,2) == 'et') {
            if (level == 0 || level == 1 || level == 4) {
                tr.className = 'hiddenRow';
            }
            else {
                tr.className = '';
            }
        }
    }
    //加入【详细】切换文字变化 --Findyou
    detail_class=document.getElementsByClassName('detail');
	//console.log(detail_class.length)
	if (level == 3) {
		for (var i = 0; i < detail_class.length; i++){
			detail_class[i].innerHTML="收起"
		}
	}
	else{
			for (var i = 0; i < detail_class.length; i++){
			detail_class[i].innerHTML="详细"
		}
	}
}
//add Error button event --Findyou v0.8.2.3
function showClassDetail(cid, count) {
    var id_list = Array(count);
    var toHide = 1;
    for (var i = 0; i < count; i++) {
        tid0 = 't' + cid.substr(1) + '_' + (i+1);
        tid = 'f' + tid0;
        tr = document.getElementById(tid);
        if (!tr) {
            tid = 'p' + tid0;
            tr = document.getElementById(tid);
        }
        if (!tr) {
            tid = 'e' + tid0;
            tr = document.getElementById(tid);
        }
        id_list[i] = tid;
        if (tr.className) {
            toHide = 0;
        }
    }
    for (var i = 0; i < count; i++) {
        tid = id_list[i];
        //修改点击无法收起的BUG，加入【详细】切换文字变化 --Findyou
        if (toHide) {
            document.getElementById(tid).className = 'hiddenRow';
            document.getElementById(cid).innerText = "详细"
        }
        else {
            document.getElementById(tid).className = '';
            document.getElementById(cid).innerText = "收起"
        }
    }
}
function html_escape(s) {
    s = s.replace(/&/g,'&');
    s = s.replace(/</g,'<');
    s = s.replace(/>/g,'>');
    return s;
}
</script>
</body>
</html>
"""
    # variables: (title, generator, stylesheet, heading, report, ending)
 
 
    # ------------------------------------------------------------------------
    # Stylesheet
    #
    # alternatively use a <link> for external style sheet, e.g.
    #   <link rel="stylesheet" href="$url" type="text/css">
 
    STYLESHEET_TMPL = """
<style type="text/css" media="screen">
body        { font-family: Microsoft YaHei,Tahoma,arial,helvetica,sans-serif;padding: 20px; font-size: 100%; }
table       { font-size: 100%; }
/* -- heading ---------------------------------------------------------------------- */
.heading {
    margin-top: 0ex;
    margin-bottom: 1ex;
}
.heading .description {
    margin-top: 4ex;
    margin-bottom: 6ex;
}
/* -- report ------------------------------------------------------------------------ */
#total_row  { font-weight: bold; }
.passCase   { color: #5cb85c; }
.failCase   { color: #d9534f; font-weight: bold; }
.errorCase  { color: #f0ad4e; font-weight: bold; }
.hiddenRow  { display: none; }
.testcase   { margin-left: 2em; }
</style>
"""
 
    # ------------------------------------------------------------------------
    # Heading
    #
 
    HEADING_TMPL = """<div class='heading'>
<h1 style="font-family: Microsoft YaHei">%(title)s</h1>
%(parameters)s
<p class='description'>%(description)s</p>
</div>
""" # variables: (title, parameters, description)
 
    HEADING_ATTRIBUTE_TMPL = """<p class='attribute'><strong>%(name)s : </strong> %(value)s</p>
""" # variables: (name, value)
 
 
 
    # ------------------------------------------------------------------------
    # Report
    #
    # 汉化,加美化效果 --Findyou
    REPORT_TMPL = """
<p id='show_detail_line'>
<a class="btn btn-primary" href='javascript:showCase(4)'>概要{ %(passrate)s }</a>
<a class="btn btn-success" href='javascript:showCase(0)'>通过{ %(Pass)s }</a>
<a class="btn btn-danger" href='javascript:showCase(1)'>失败{ %(fail)s }</a>
<a class="btn btn-warning" href='javascript:showCase(2)'>错误{ %(error)s }</a>
<a class="btn btn-info" href='javascript:showCase(3)'>所有{ %(count)s }</a>
<a class="btn btn-performance" title="转到性能测试跑分汇总表格" href="Results_Excel/%(test_plat_Ex)s_%(test_type_Ex)s.xls">附:性能测试跑分结果</a>
</p>
<table id='result_table' class="table table-condensed table-bordered table-hover">
<colgroup>
<col align='left' />
<col align='right' />
<col align='right' />
<col align='right' />
<col align='right' />
<col align='right' />
</colgroup>
<tr id='header_row' class="text-center active" style="font-weight: bold;font-size: 14px;">
    <td>用例集/测试用例</td>
    <td>总计</td>
    <td>通过</td>
    <td>失败</td>
    <td>错误</td>
    <td>详细</td>
</tr>
%(test_list)s
<script type="text/javascript"> window.onload = function(){ showCase(4); } </script> 
<tr id='total_row' class="text-center info">
    <td>总计</td>
    <td>%(count)s</td>
    <td>%(Pass)s</td>
    <td>%(fail)s</td>
    <td>%(error)s</td>
    <td>通过率：%(passrate)s</td>
</tr>
</table>
""" # variables: (test_list, count, Pass, fail, error ,passrate)
    REPORT_CLASS_TMPL = r"""
<tr class='%(style)s'>
    <td>%(desc)s</td>
    <td class="text-center">%(count)s</td>
    <td class="text-center">%(Pass)s</td>
    <td class="text-center">%(fail)s</td>
    <td class="text-center">%(error)s</td>
    <td class="text-center"><a href="javascript:showClassDetail('%(cid)s',%(count)s)" class="detail" id='%(cid)s'>详细</a></td>
</tr>
""" # variables: (style, desc, count, Pass, fail, error, cid)
 
    #有output内容的样式，去掉原来JS效果，美化展示效果  -Findyou v0.8.2.3
    REPORT_TEST_WITH_OUTPUT_TMPL = r"""
<tr id='%(tid)s' class='%(Class)s'>
    <td class='%(style)s'><div class='testcase'>%(desc)s</div></td>
    <td colspan='5' align='center'>
    <!--默认收起output信息 -Findyou
    <button id='btn_%(tid)s' type="button"  class="btn-xs collapsed" data-toggle="collapse" data-target='#div_%(tid)s'>%(status)s</button>
    <div id='div_%(tid)s' class="collapse">  -->
    <!-- 默认展开output信息 -Findyou -->
    <button id='btn_%(tid)s' type="button"  class="btn-xs" data-toggle="collapse" data-target='#div_%(tid)s'>%(status)s</button>
    <div id='div_%(tid)s' align="left" class="collapse in">
    <pre>
    %(script)s
    </pre>
    </div>
    </td>
</tr>
""" # variables: (tid, Class, style, desc, status)
    # 无output内容样式改为button，按钮效果为不可点击  -Findyou v0.8.2.3
    REPORT_TEST_NO_OUTPUT_TMPL = r"""
<tr id='%(tid)s' class='%(Class)s'>
    <td class='%(style)s'><div class='testcase'>%(desc)s</div></td>
    <td colspan='5' align='center'><button id='btn_%(tid)s' type="button"  class="btn-xs" disabled="disabled" data-toggle="collapse" data-target='#div_%(tid)s'>%(status)s</button></td>
</tr>
""" # variables: (tid, Class, style, desc, status)
    REPORT_TEST_OUTPUT_TMPL = r"""
<!--  output mage Mark-->
测试节点基本信息:
节点IP: [%(ip)s]
系统类别: [%(os_name)s],系统版本: [%(os_ver)s],内核版本: [%(kernel_ver)s]
%(test_StartTime)s
详情:<a href="Detail/LogInfo/%(test_casename)s/Node%(test_nodenum)s_%(ip)s.txt" target="_blank">节点状态及日志信息</a>
""" # variables: (id, output)
 
    # ------------------------------------------------------------------------
    # ENDING
    #
    # 增加返回顶部按钮  --Findyou
    ENDING_TMPL = """<div id='ending'> </div>
    <div style=" position:fixed;right:50px; bottom:30px; width:20px; height:20px;cursor:pointer">
    <a href="#"><span class="glyphicon glyphicon-eject" style = "font-size:30px;" aria-hidden="true">
    </span></a></div>
    """
 
# -------------------- The end of the Template class -------------------
 
 
TestResult = unittest.TestResult
 
class _TestResult(TestResult):
    # note: _TestResult is a pure representation of results.
    # It lacks the output and reporting ability compares to unittest._TextTestResult.
 
    def __init__(self, verbosity=1):
        TestResult.__init__(self)
        self.stdout0 = None
        self.stderr0 = None
        self.success_count = 0
        self.failure_count = 0
        self.error_count = 0
        self.verbosity = verbosity
 
        # result is a list of result in 4 tuple
        # (
        #   result code (0: success; 1: fail; 2: error),
        #   TestCase object,
        #   Test output (byte string),
        #   stack trace,
        # )
        self.result = []
        #增加一个测试通过率 --Findyou
        self.passrate=float(0)
 
 
    def startTest(self, test):
        TestResult.startTest(self, test)
        # just one buffer for both stdout and stderr
        self.outputBuffer = StringIO()
        stdout_redirector.fp = self.outputBuffer
        stderr_redirector.fp = self.outputBuffer
        self.stdout0 = sys.stdout
        self.stderr0 = sys.stderr
        sys.stdout = stdout_redirector
        sys.stderr = stderr_redirector
 
 
    def complete_output(self):
        """
        Disconnect output redirection and return buffer.
        Safe to call multiple times.
        """
        if self.stdout0:
            sys.stdout = self.stdout0
            sys.stderr = self.stderr0
            self.stdout0 = None
            self.stderr0 = None
        return self.outputBuffer.getvalue()
 
 
    def stopTest(self, test):
        # Usually one of addSuccess, addError or addFailure would have been called.
        # But there are some path in unittest that would bypass this.
        # We must disconnect stdout in stopTest(), which is guaranteed to be called.
        self.complete_output()
 
 
    def addSuccess(self, test):
        self.success_count += 1
        TestResult.addSuccess(self, test)
        output = self.complete_output()
        self.result.append((0, test, output, ''))
        if self.verbosity > 1:
            sys.stderr.write('ok ')
            sys.stderr.write(str(test))
            sys.stderr.write('\n')
        else:
            sys.stderr.write('.')
 
    def addError(self, test, err):
        self.error_count += 1
        TestResult.addError(self, test, err)
        _, _exc_str = self.errors[-1]
        output = self.complete_output()
        self.result.append((2, test, output, _exc_str))
        if self.verbosity > 1:
            sys.stderr.write('E  ')
            sys.stderr.write(str(test))
            sys.stderr.write('\n')
        else:
            sys.stderr.write('E')
 
    def addFailure(self, test, err):
        self.failure_count += 1
        TestResult.addFailure(self, test, err)
        _, _exc_str = self.failures[-1]
        output = self.complete_output()
        self.result.append((1, test, output, _exc_str))
        if self.verbosity > 1:
            sys.stderr.write('F  ')
            sys.stderr.write(str(test))
            sys.stderr.write('\n')
        else:
            sys.stderr.write('F')
 
 
class HTMLTestRunner(Template_mixin):
    """
    """
    def __init__(self, stream=sys.stdout, verbosity=1,title=None,description=None,test_type=None,test_plat=None):
        self.stream = stream
        self.verbosity = verbosity
        if title is None:
            self.title = self.DEFAULT_TITLE
        else:
            self.title = title
        if description is None:
            self.description = self.DEFAULT_DESCRIPTION
        else:
            self.description = description
        if test_type is None:
            self.test_type = self.DEFAULT_TYPE
        else:
            self.test_type = test_type
        if test_plat is None:
            self.test_plat = self.DEFAULT_PLATFORM
        else:
            self.test_plat = test_plat
 
        self.startTime = datetime.datetime.now()
 
 
    def run(self, test):
        "Run the given test case or test suite."
        result = _TestResult(self.verbosity)
        test(result)
        self.stopTime = datetime.datetime.now()
        self.generateReport(test, result)
        # print >>sys.stderr, '\nTime Elapsed: %s' % (self.stopTime-self.startTime)
        sys.stderr.write('\nTime Elapsed: %s\n' % (self.stopTime-self.startTime))
        return result
 
 
    def sortResult(self, result_list):
        # unittest does not seems to run in any particular order.
        # Here at least we want to group them together by class.
        rmap = {}
        classes = []
        for n,t,o,e in result_list:
            cls = t.__class__
            # if not rmap.has_key(cls):
            if cls not in rmap:
                rmap[cls] = []
                classes.append(cls)
            rmap[cls].append((n,t,o,e))
        r = [(cls, rmap[cls]) for cls in classes]
        return r
 
    #替换测试结果status为通过率 --Findyou
    def getReportAttributes(self, result):
        """
        Return report attributes as a list of (name, value).
        Override this to add custom attributes.
        """
        startTime = str(self.startTime)[:19]
        duration = str(self.stopTime - self.startTime)
        status = []
        status.append('共 %s' % (result.success_count + result.failure_count + result.error_count))
        if result.success_count: status.append('通过 %s'    % result.success_count)
        if result.failure_count: status.append('失败 %s' % result.failure_count)
        if result.error_count:   status.append('错误 %s'   % result.error_count  )
        if status:
            status = '，'.join(status)
        # 合入Github：boafantasy代码
            if (result.success_count + result.failure_count + result.error_count) > 0:
                self.passrate = str("%.2f%%" % (float(result.success_count) / float(result.success_count + result.failure_count + result.error_count) * 100))
            else:
                self.passrate = "0.00 %"
        else:
            status = 'none'
        return [
            (u'测试类型', self.test_type),
            (u'测试平台', self.test_plat),
            (u'统计时间',startTime),
            #(u'合计耗时',duration), #不需要此功能了
            (u'测试结果',status + "，通过率= "+self.passrate),
        ]
 
 
    def generateReport(self, test, result):
        report_attrs = self.getReportAttributes(result)
        generator = 'HTMLTestRunner %s' % __version__
        stylesheet = self._generate_stylesheet()
        heading = self._generate_heading(report_attrs)
        report = self._generate_report(result)
        ending = self._generate_ending()
        output = self.HTML_TMPL % dict(
            title = saxutils.escape(self.title),
            generator = generator,
            stylesheet = stylesheet,
            heading = heading,
            report = report,
            ending = ending,
        )
        self.stream.write(output.encode('utf8'))
 
 
    def _generate_stylesheet(self):
        return self.STYLESHEET_TMPL
 
    #增加Tester显示 -Findyou
    def _generate_heading(self, report_attrs):
        a_lines = []
        for name, value in report_attrs:
            line = self.HEADING_ATTRIBUTE_TMPL % dict(
                    name = saxutils.escape(name),
                    value = saxutils.escape(value),
                )
            a_lines.append(line)
        heading = self.HEADING_TMPL % dict(
            title = saxutils.escape(self.title),
            parameters = ''.join(a_lines),
            description = saxutils.escape(self.description),
            test_plat= saxutils.escape(self.test_plat),
        )
        return heading
 
    #测试用例名称转换成对应的中文表达，便于见名知义
    def getCaseFullName(self,inputName):
    
        TestCaseFile='TestCaseRef.txt'
        TestCasePath = TestcasePath + '/' + TestCaseFile
        fr = open(TestCasePath,'r')
        dic = {}
        keys = []
        for line in fr:
            v = line.strip().split('=')
            dic[v[0]] = v[1]
            keys.append(v[0])
        fr.close()
        outputName = dic[inputName]
        #print('======================================')
        #print(outputName)
        #print('======================================')
    
        return outputName


    #生成报告  --Findyou添加注释
    def _generate_report(self, result):
        rows = []
        sortedResult = self.sortResult(result.result)
        for cid, (cls, cls_results) in enumerate(sortedResult):
            # subtotal for a class
            np = nf = ne = 0
            for n,t,o,e in cls_results:
                if n == 0: np += 1
                elif n == 1: nf += 1
                else: ne += 1
 
            # format class description
            if cls.__module__ == "__main__":
                name = cls.__name__
            else:
                name = "%s.%s" % (cls.__module__, cls.__name__)
            doc = cls.__doc__ and cls.__doc__.split("\n")[0] or ""
            desc = doc and '%s: %s' % (name, doc) or name
            tmp_desc = desc.replace('Test.','')
            desc = self.getCaseFullName(tmp_desc)            

            row = self.REPORT_CLASS_TMPL % dict(
                style = ne > 0 and 'warning' or nf > 0 and 'danger' or 'success',
                desc = desc,
                count = np+nf+ne,
                Pass = np,
                fail = nf,
                error = ne,
                cid = 'c%s' % (cid+1),
            )
            rows.append(row)
 
            for tid, (n,t,o,e) in enumerate(cls_results):
                self._generate_report_test(rows, cid, tid, n, t, o, e)
 
        report = self.REPORT_TMPL % dict(
            test_list = ''.join(rows),
            count = str(result.success_count+result.failure_count+result.error_count),
            Pass = str(result.success_count),
            fail = str(result.failure_count),
            error = str(result.error_count),
            passrate =self.passrate,
            test_type_Ex=self.test_type,
            test_plat_Ex=self.test_plat,
        )
        return report
 
    def get_case_name(self,input_str):

        '''
        #获取测试返回的列表信息,截取其中的测试用例名称
        #示例:
        test_SpecJvm2008_Node3 (Test.SpecJvm2008)
        获取SpecJvm2008
        '''
        init_str = str(input_str)

        find_str = re.findall(r'[(](.*?)[)]', str(init_str)) #取出括号部分内容
        #print(find_str)
        first_str = ''.join(find_str)
        sec_list = first_str.split('.')
        return sec_list[1]

    def get_node_num(self,input_str):

        '''
        #获取测试返回的列表信息,截取其中的测试节点号码
        #示例:
        test_SpecJvm2008_Node3 (Test.SpecJvm2008)
        获取->Node3,最终获取->3
        '''
        init_str = str(input_str)

        str_info = init_str.split(' ')
        first_str = str_info[0]
        sec_list = first_str.split('_')
        sec_str = sec_list[-1]
        third_str = sec_str.lstrip('Node')
        return third_str

    def get_os_name(self,TestType,Platform,TestCase,NodeNum,ip_input):

        ip_file = ResultPath + str(TestType) + '/' + str(Platform) + '/' + 'Detail/OSInfo/' + str(TestCase) + '/Node' + str(NodeNum) + '_' + str(ip_input) + '.ini'
        if not os.path.isfile(ip_file):
           #tmpTestCase = TestCase.replace("_","-")
           tmpTestCase = getTransferKeyName(TestCase)
           ip_file = ResultPath + str(TestType) + '/' + str(Platform) + '/' + 'Detail/OSInfo/' + str(tmpTestCase) + '/Node' + str(NodeNum) + '_' + str(ip_input) + '.ini'
        #config = ConfigParser.ConfigParser()
        config = myconf()

        config.readfp(open(ip_file))
        sectionName='Main'
        keyName='Product'
        resultStr=config.get(sectionName,keyName)
        retCode=resultStr
        return retCode

    def get_os_version(self,TestType,Platform,TestCase,NodeNum,ip_input):

        ip_file = ResultPath + str(TestType) + '/' + str(Platform) + '/' + 'Detail/OSInfo/' + str(TestCase) + '/Node' + str(NodeNum) + '_' + str(ip_input) + '.ini'
        if not os.path.isfile(ip_file):
           #tmpTestCase = TestCase.replace("_","-")
           tmpTestCase = getTransferKeyName(TestCase)
           ip_file = ResultPath + str(TestType) + '/' + str(Platform) + '/' + 'Detail/OSInfo/' + str(tmpTestCase) + '/Node' + str(NodeNum) + '_' + str(ip_input) + '.ini'
        #config = ConfigParser.ConfigParser()
        config = myconf()

        config.readfp(open(ip_file))
        sectionName='Main'
        keyName='UUID'
        resultStr=config.get(sectionName,keyName)
        retCode=resultStr
        return retCode

    def get_kernel_version(self,TestType,Platform,TestCase,NodeNum,ip_input):

        ip_file = ResultPath + str(TestType) + '/' + str(Platform) + '/' + 'Detail/OSInfo/' + str(TestCase) + '/Node' + str(NodeNum) + '_' + str(ip_input) + '.ini'
        if not os.path.isfile(ip_file):
           #tmpTestCase = TestCase.replace("_","-")
           tmpTestCase = getTransferKeyName(TestCase)
           ip_file = ResultPath + str(TestType) + '/' + str(Platform) + '/' + 'Detail/OSInfo/' + str(tmpTestCase) + '/Node' + str(NodeNum) + '_' + str(ip_input) + '.ini'
        #config = ConfigParser.ConfigParser()
        config = myconf()

        config.readfp(open(ip_file))
        sectionName='Main'
        keyName='Kernel_Version'
        resultStr=config.get(sectionName,keyName)
        retCode=resultStr
        return retCode

    def get_test_time(self,TestType,Platform,TestCase,NodeNum,ip_input):

        ip_file = ResultPath + str(TestType) + '/' + str(Platform) + '/' + 'Detail/TestInfo/' + str(TestCase) + '/Node' + str(NodeNum) + '_' + str(ip_input) + '.ini'
        if not os.path.isfile(ip_file):
           tmpTestCase = getTransferKeyName(TestCase)
           ip_file = ResultPath + str(TestType) + '/' + str(Platform) + '/' + 'Detail/TestInfo/' + str(tmpTestCase) + '/Node' + str(NodeNum) + '_' + str(ip_input) + '.ini'
        #config = ConfigParser.ConfigParser()
        config = myconf()

        #self.remove_BOM(ip_file)
        config.readfp(open(ip_file))
        sectionName='TestInfo'
        keyName='StartTime'
        resultStr=config.get(sectionName,keyName)
        retCode=resultStr
        return retCode

    #------------------------------------------------------------------------------------
    #按照测试部门要求:只需要对需要进行监控的性能或压力测试添加测试开始时间显示
    #因此，本函数功能是筛选出来需要显示测试时间的测试用例类型(文件字段设置为1则需要显示)
    #------------------------------------------------------------------------------------
    def getCaseType(self,inputName):

        TestCaseFile='TestCaseType.txt'
        TestCasePath = TestcasePath + '/' + TestCaseFile
        fr = open(TestCasePath,'r')
        dic = {}
        keys = []
        for line in fr:
            v = line.strip().split('=')
            dic[v[0]] = v[1]
            keys.append(v[0])
        fr.close()
        outputType = dic[inputName]

        return outputType

 
    def _generate_report_test(self, rows, cid, tid, n, t, o, e):
        # e.g. 'pt1.1', 'ft1.1', etc
        has_output = bool(o or e)
        # ID修改点为下划线,支持Bootstrap折叠展开特效 - Findyou v0.8.2.1
        #增加error分类 - Findyou v0.8.2.3
        tid = (n == 0 and 'p' or n == 1 and 'f' or 'e') + 't%s_%s' % (cid + 1, tid + 1)
        name = t.id().split('.')[-1]
        doc = t.shortDescription() or ""
        desc = doc and ('%s: %s' % (name, doc)) or name
        old_desc = desc
        tmpl = has_output and self.REPORT_TEST_WITH_OUTPUT_TMPL or self.REPORT_TEST_NO_OUTPUT_TMPL
 
        # utf-8 支持中文 - Findyou
         # o and e should be byte string because they are collected from stdout and stderr?
        if isinstance(o, str):
            # TODO: some problem with 'string_escape': it escape \n and mess up formating
            # uo = unicode(o.encode('string_escape'))
            try:
                uo = o
            except:
                uo = o.decode('utf-8')
        else:
            uo = o
        if isinstance(e, str):
            # TODO: some problem with 'string_escape': it escape \n and mess up formating
            # ue = unicode(e.encode('string_escape'))
            try:
                ue = e
            except:
                ue = e.decode('utf-8')
        else:
            ue = e
 
        print('------获取测试用例名称----------------------')
        Case_Name = self.get_case_name(t)
        print(Case_Name)
        print('------获取节点序号----------------------')
        Node_Num = self.get_node_num(t)
        print(Node_Num)

        ip_info = get_IP(self.test_type, self.test_plat, str(Case_Name), str(Node_Num) )
        print(ip_info)

        os_name_val = self.get_os_name(self.test_type, self.test_plat, str(Case_Name), str(Node_Num), ip_info )
        print(os_name_val)

        os_version_val = self.get_os_version(self.test_type, self.test_plat, str(Case_Name), str(Node_Num), ip_info )
        print(os_version_val)

        kernel_version_val = self.get_kernel_version(self.test_type, self.test_plat, str(Case_Name), str(Node_Num), ip_info )
        print(kernel_version_val)

        test_startTime_val = self.get_test_time(self.test_type, self.test_plat, str(Case_Name), str(Node_Num), ip_info )
        print(test_startTime_val)

        test_type_val = self.test_type
        test_plat_val = self.test_plat
        #test_casename_val = str(Case_Name)
        test_casename_val = getTransferKeyName(Case_Name)
        test_nodenum_val = str(Node_Num)

        #获取测试用例类型，用于显示测试开始时间
        desc_tmp = old_desc
	back_desc = desc_tmp.replace('test_','',1).split('_')[-1]
        tmp_str = "_" + back_desc
        tmp_desc = desc_tmp.replace('test_','',1).replace(tmp_str,"")
        type_case = self.getCaseType(tmp_desc)
     
        #------------------------------------------------------------------------------------
        #原来的测试节点名称(函数名)修改为用户友好的节点说明信息
        #并发测试节点_1
        #并发测试节点_2
        #并发测试节点_3
        #------------------------------------------------------------------------------------
        num_node = back_desc.replace('Node','',1)
        str_node_name = '并发测试节点_' + num_node
        print('================================================')
        print(str_node_name)
        print('================================================')

        script = self.REPORT_TEST_OUTPUT_TMPL % dict(
            #id = tid,
            #output = saxutils.escape(uo+ue),
            ip = str(ip_info),
            output = str(t),
            os_name = str(os_name_val),
            os_ver = str(os_version_val),
            kernel_ver = str(kernel_version_val),
            #test_StartTime = str(test_startTime_val),
            #test_StartTime = "StartTime: [" + str(test_startTime_val)+"]" if int(type_case) else "",
            test_StartTime = "测试开始时间: [" + str(test_startTime_val)+"]" if int(type_case) else "",
            test_type = str(test_type_val),
            test_plat = str(test_plat_val),
            test_casename = str(test_casename_val),
            test_nodenum = str(test_nodenum_val),
        )
 
        row = tmpl % dict(
            tid = tid,
            Class = (n == 0 and 'hiddenRow' or 'none'),
            style = n == 2 and 'errorCase' or (n == 1 and 'failCase' or 'passCase'),
            desc = str_node_name,
            script = script,
            status = self.STATUS[n],
        )
        rows.append(row)
        if not has_output:
            return
 
    def _generate_ending(self):
        return self.ENDING_TMPL
 
 
##############################################################################
# Facilities for running tests from the command line
##############################################################################
 
# Note: Reuse unittest.TestProgram to launch test. In the future we may
# build our own launcher to support more specific command line
# parameters like test title, CSS, etc.
class TestProgram(unittest.TestProgram):
    """
    A variation of the unittest.TestProgram. Please refer to the base
    class for command line parameters.
    """
    def runTests(self):
        # Pick HTMLTestRunner as the default test runner.
        # base class's testRunner parameter is not useful because it means
        # we have to instantiate HTMLTestRunner before we know self.verbosity.
        if self.testRunner is None:
            self.testRunner = HTMLTestRunner(verbosity=self.verbosity)
        unittest.TestProgram.runTests(self)
 
main = TestProgram
 
##############################################################################
# Executing this module from the command line
##############################################################################
 
if __name__ == "__main__":
    main(module=None)
