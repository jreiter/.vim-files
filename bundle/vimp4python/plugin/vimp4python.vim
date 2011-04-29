" VIM integration via P4Python
" Depends on P4Python API
" P4RevGraph requires perl and Graph::Easy module
" Uses the connection environment from the current working directory.
" Oriented towards commands that can be run on a single file.
" Get help by typing :help vimp4python.

"
" Copyright (c) Perforce Software, Inc., 1997-2010. All rights reserved
"
" Redistribution and use in source and binary forms, with or without
" modification, are permitted provided that the following conditions are met:
" 
" 1.  Redistributions of source code must retain the above copyright
"     notice, this list of conditions and the following disclaimer.
" 
" 2.  Redistributions in binary form must reproduce the above copyright
"     notice, this list of conditions and the following disclaimer in the
"     documentation and/or other materials provided with the distribution.
" 
" THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
" 'AS IS' AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
" LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
" FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL PERFORCE
" SOFTWARE, INC. BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
" SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
" LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
" DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
" ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR
" TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF
" THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH
" DAMAGE.
" 
" User contributed content on the Perforce Public Depot is not supported by Perforce,
" although it may be supported by its author. This applies to all contributions 
" even those submitted by Perforce employees.
"

"
" Standard code to avoid loading twice and to allow not loading
" Also detects if python is available
"
if exists("loaded_vimp4python")
    finish
endif
let loaded_vimp4python=1
if (has('python') || has('python/dyn'))
    let loaded_vimp4python=1
else
    finish
endif

"
" check for P4Python API
"
python << EOF
try:
    import vim, P4
    p4 = P4.P4()
    vim.command("let b:hasp4 = \"1\"")
except:
    vim.command("let b:hasp4 = \"0\"")
EOF
if b:hasp4 == "0"
    finish
endif

" set this to 0 to disable ruler calls
let P4SetRuler = 1

"
" define the mappings that provide the user interface to this plug-in
"
augroup vimp4python

    " events
    autocmd BufRead * call <SID>P4InitialBufferVariables()
    autocmd BufRead * call <SID>P4FstatVars()

    " Keyboard shortcuts - default <Leader> is \
    " (listed in order of shortcuts)
    map <silent> <Leader>p4a :echo <SID>P4Add()<CR>
    map <silent> <Leader>p4b :echo <SID>P4Branches()<CR>
    map <silent> <Leader>p4c :echo <SID>P4Clients()<CR>
    map <silent> <Leader>p4d :echo <SID>P4Delete()<CR>
    map <silent> <Leader>p4e :echo <SID>P4Edit()<CR>
    map <silent> <Leader>p4f :echo <SID>P4Fstat()<CR> 
    map <silent> <Leader>p4g :echo <SID>P4Sync()<CR>
    map <silent> <Leader>p4h :echo <SID>P4Filelog()<CR>
    map <silent> <Leader>p4i :echo <SID>P4Info()<CR>
    map <silent> <Leader>p4k :echo <SID>P4Diff()<CR>
    map <silent> <Leader>p4l :echo <SID>P4Lock()<CR>
    map <silent> <Leader>p4n :echo <SID>P4Annotate()<CR>
    map <silent> <Leader>p4o :echo <SID>P4Opened()<CR>
    map <silent> <Leader>p4p :echo <SID>PluginHelp()<CR>
    map <silent> <Leader>p4r :echo <SID>P4Revert()<CR>
    map <silent> <Leader>p4s :echo <SID>P4Submit()<CR>
    map <silent> <Leader>p4t :echo <SID>P4Tag()<CR>
    map <silent> <Leader>p4u :echo <SID>P4Unlock()<CR>
    map <silent> <Leader>p4w :echo <SID>P4Where()<CR>
    map <silent> <Leader>p4x :echo <SID>P4Fix()<CR>
    map <silent> <Leader>p4z :echo <SID>P4Run()<CR>

    " menus
    " (listed in order of shortcuts)
    menu <silent> &Perforce.Plugin\ Help :echo <SID>PluginHelp()<CR>
    menu <silent> &Perforce.&Add :echo <SID>P4Add()<CR>
    menu <silent> &Perforce.&Branches\ for\ current\ user :echo <SID>P4Branches()<CR>
    menu <silent> &Perforce.&Clients\ for\ current\ user :echo <SID>P4Clients()<CR>
    menu <silent> &Perforce.&Delete :echo <SID>P4Delete()<CR>
    menu <silent> &Perforce.&Edit :echo <SID>P4Edit()<CR>
    menu <silent> &Perforce.&Fstat :echo <SID>P4Fstat()<CR>
    menu <silent> &Perforce.Connection\ &Info :echo <SID>P4Info()<CR>
    menu <silent> &Perforce.File&log :echo <SID>P4Filelog()<CR>
    menu <silent> &Perforce.A&nnotate :echo <SID>P4Annotate()<CR>
    menu <silent> &Perforce.&Opened\ files :echo <SID>P4Opened()<CR>
    menu <silent> &Perforce.&Revert :echo <SID>P4Revert()<CR>
    menu <silent> &Perforce.&Submit :echo <SID>P4Submit()<CR>
    menu <silent> &Perforce.&Tag :echo <SID>P4Tag()<CR>
    menu <silent> &Perforce.&Where :echo <SID>P4Where()<CR>
    menu <silent> &Perforce.S&ync :echo <SID>P4Sync()<CR>
    menu <silent> &Perforce.Run\ Command :echo <SID>P4Run()<CR>
    menu <silent> &Perforce.File.Attribute\ set :echo <SID>P4Attribute()<CR>
    menu <silent> &Perforce.File.Attribute\ list :echo <SID>P4Attributes()<CR>
    menu <silent> &Perforce.File.Lock :echo <SID>P4Lock()<CR>
    menu <silent> &Perforce.File.Unlock :echo <SID>P4Unlock()<CR>
    menu <silent> &Perforce.Branching.Branch\ Info :echo <SID>P4Branch()<CR>
    menu <silent> &Perforce.File.Changelist\ Info :echo <SID>P4Change()<CR>
    menu <silent> &Perforce.File.Changelists\ For\ File :echo <SID>P4Changes()<CR>
    menu <silent> &Perforce.Workspace.Workspace\ Info :echo <SID>P4Client()<CR>
    menu <silent> &Perforce.File.Diff :echo <SID>P4Diff()<CR>
    menu <silent> &Perforce.File.Diff2 :echo <SID>P4Diff2()<CR>
    menu <silent> &Perforce.Jobs.Fix\ Job :echo <SID>P4Fix()<CR>
    menu <silent> &Perforce.Jobs.Fixes\ for\ Job :echo <SID>P4Fixes()<CR>
    menu <silent> &Perforce.Other.Grep :echo <SID>P4Grep()<CR>
    menu <silent> &Perforce.User.Group\ Info :echo <SID>P4Group()<CR>
    menu <silent> &Perforce.User.Group\ List :echo <SID>P4Groups()<CR>
    menu <silent> &Perforce.Other.Help :echo <SID>P4Help()<CR>
    menu <silent> &Perforce.Branching.Integrated :echo <SID>P4Integrated()<CR>
    menu <silent> &Perforce.Branching.Rev\ Graph :echo <SID>P4RevGraph()<CR>
    menu <silent> &Perforce.Jobs.Job\ Info :echo <SID>P4Job()<CR>
    menu <silent> &Perforce.Jobs.Job\ List :echo <SID>P4Jobs()<CR>
    menu <silent> &Perforce.Labels.Label\ Info :echo <SID>P4Label()<CR>
    menu <silent> &Perforce.Labels.Label\ List :echo <SID>P4Labels()<CR>
    menu <silent> &Perforce.File.Print :echo <SID>P4Print()<CR>
    menu <silent> &Perforce.User.Protections\ Info :echo <SID>P4Protects()<CR>
    menu <silent> &Perforce.File.Reopen\ to\ changelist :echo <SID>P4ReopenChange()<CR>
    menu <silent> &Perforce.File.Reopen\ type :echo <SID>P4ReopenType()<CR>
    menu <silent> &Perforce.File.Resolve\ automatically :echo <SID>P4Resolve()<CR>
    menu <silent> &Perforce.File.Resolve\ status :echo <SID>P4Resolved()<CR>
    menu <silent> &Perforce.Other.Set :echo <SID>P4Set()<CR>
    menu <silent> &Perforce.File.Shelve :echo <SID>P4Shelve()<CR>
    menu <silent> &Perforce.File.Remove\ from\ shelf :echo <SID>P4ShelveRemove()<CR>
    menu <silent> &Perforce.File.Sizes :echo <SID>P4Sizes()<CR>
    menu <silent> &Perforce.User.Tickets :echo <SID>P4Tickets()<CR>
    menu <silent> &Perforce.File.Unshelve :echo <SID>P4Unshelve()<CR>
    menu <silent> &Perforce.User.User\ Info :echo <SID>P4User()<CR>
    menu <silent> &Perforce.User.User\ list :echo <SID>P4Users()<CR>
    menu <silent> &Perforce.File.Verify :echo <SID>P4Verify()<CR>
    menu <silent> &Perforce.Admin.Counters :echo <SID>P4Counters()<CR>
    menu <silent> &Perforce.Admin.Database\ Schema :echo <SID>P4Dbschema()<CR>
    menu <silent> &Perforce.Admin.Database\ Statistics :echo <SID>P4Dbstat()<CR>
    menu <silent> &Perforce.Admin.Depots :echo <SID>P4Depots()<CR>
    menu <silent> &Perforce.Admin.Jobspec :echo <SID>P4Jobspec()<CR>
    menu <silent> &Perforce.Admin.License\ Info :echo <SID>P4License()<CR>
    menu <silent> &Perforce.Admin.Database\ Lock\ Info :echo <SID>P4Lockstat()<CR>
    menu <silent> &Perforce.Admin.Log\ Info :echo <SID>P4Logstat()<CR>
    menu <silent> &Perforce.Admin.Log\ Tail :echo <SID>P4Logtail()<CR>
    menu <silent> &Perforce.Admin.Monitor :echo <SID>P4Monitor()<CR>
    menu <silent> &Perforce.Admin.Obliterate\ Preview :echo <SID>P4Obliterate()<CR>
    menu <silent> &Perforce.Admin.Protections\ Table :echo <SID>P4Protect()<CR>
    menu <silent> &Perforce.Admin.Trigger\ Table :echo <SID>P4Triggers()<CR>
    menu <silent> &Perforce.Admin.Tunables :echo <SID>P4Tunables()<CR>
    menu <silent> &Perforce.Admin.Typemap\ Table :echo <SID>P4Typemap()<CR>
augroup END

"
" initialize status variables
"
function s:P4InitialBufferVariables()
    let b:headrev=""
    let b:headtype=""
    let b:depotfile=""
    let b:haverev=""
    let b:action=""
    let b:changelist=""
endfunction

"
" init ruler for status messages
"
if( strlen( &rulerformat ) == 0 ) && ( P4SetRuler == 1 )
    set rulerformat=%60(%=%{P4RulerStatus()}\ %4l,%-3c\ %3p%%%)
endif

"
" filelog
"
function s:P4Filelog()
python << EOF
import vim, P4, types
from datetime import datetime
p4 = P4.P4()
p4.prog = "VIM Integration"
P4Exception = P4.P4Exception
try:
    p4.connect()
    p4.tagged = True
    out = p4.run("filelog", vim.current.buffer.name)
    if not (isinstance(out, types.NoneType)):
        m = out[0]
        print m['depotFile']
        print "{0:<5}{1:<10}{2:<15}{3:<20}{4:<12}description".format('rev','change','action','user','date') 
    	for i in range(len(m['rev'])):
            timeobj = datetime.fromtimestamp(float(m['time'][i]))
            timestr = timeobj.strftime('%Y/%m/%d')
            print "{0:<5}{1:<10}{2:<15}{3:<20}{4:<12}{5}".format(m['rev'][i],m['change'][i],m['action'][i],m['user'][i],timestr,m['desc'][i]) 
    p4.disconnect()

except P4Exception:
    for e in p4.errors:
        print e
    for w in p4.warnings:
        print w
EOF
endfunction

"
" Produce string for ruler output
"
function P4RulerStatus()
    if !exists( "b:headrev" ) 
        call s:P4InitialBufferVariables()
    endif
    if b:action == ""
        if b:headrev == ""
            return "[Not in P4]" 
        else
            return "[P4: " . b:haverev . "/" . b:headrev . " (" . b:headtype . ")]"
        endif
    else
        return "[P4: " . b:action . " (". b:changelist . ")]"
    endif
endfunction

"
" fstat for ruler
"
function s:P4FstatVars()
python << EOF
import vim, P4, types
p4 = P4.P4()
p4.prog = "VIM Integration"
P4Exception = P4.P4Exception
try:
    p4.connect()
    p4.tagged = True
    out = p4.run("fstat", vim.current.buffer.name)
    if not (isinstance(out, types.NoneType)):
        m = out[0]
        change = ""
        if 'change' in m:
            change = m['change']
        action = ""
        if 'action' in m:
            action = m['action']
        headRev = ""
        if 'headRev' in m:
            headRev = m['headRev']
        headType = ""
        if 'headType' in m:
            headType = m['headType']
        haveRev = ""
        if 'haveRev' in m:
            haveRev = m['haveRev']
        depotFile = ""
        if 'depotFile' in m:
            depotFile = m['depotFile']
        vim.command("let b:headrev = \"%s\"" % headRev)
        vim.command("let b:headtype = \"%s\"" % headType)
        vim.command("let b:changelist = \"%s\"" % change)
        vim.command("let b:depotfile = \"%s\"" % depotFile)
        vim.command("let b:haverev = \"%s\"" % haveRev)
        vim.command("let b:action = \"%s\"" % action)
    p4.disconnect()

except P4Exception:
    for e in p4.errors:
        print e
    for w in p4.warnings:
        print w
EOF
endfunction

"
" fstat
"
function s:P4Fstat()
python << EOF
import vim, P4, types
p4 = P4.P4()
p4.prog = "VIM Integration"
P4Exception = P4.P4Exception
try:
    p4.connect()
    p4.tagged = True
    out = p4.run("fstat", vim.current.buffer.name)
    if not (isinstance(out, types.NoneType)):
        m = out[0]
        change = ""
        if 'change' in m:
            change = m['change']
        action = ""
        if 'action' in m:
            action = m['action']
        headRev = ""
        if 'headRev' in m:
            headRev = m['headRev']
        headType = ""
        if 'headType' in m:
            headType = m['headType']
        haveRev = ""
        if 'haveRev' in m:
            haveRev = m['haveRev']
        depotFile = ""
        if 'depotFile' in m:
            depotFile = m['depotFile']
        print "{0}: {1}/{2} ({3})".format(depotFile,haveRev,headRev,headType)
        if change != "":
            print "Opened in {0} ({1})".format(change,action)
    p4.disconnect()

except P4Exception:
    for e in p4.errors:
        print e
    for w in p4.warnings:
        print w
EOF
endfunction

"
" open for edit
"
function s:P4Edit()
python << EOF
import vim, P4, types
from datetime import datetime
p4 = P4.P4()
p4.prog = "VIM Integration"
P4Exception = P4.P4Exception
try:
    p4.connect()
    p4.tagged = False
    out = p4.run("edit", vim.current.buffer.name)
    if not (isinstance(out, types.NoneType)):
        for s in out:
            print s
    p4.disconnect()
    vim.command("edit")

except P4Exception:
    for e in p4.errors:
        print e
    for w in p4.warnings:
        print w
EOF
endfunction

"
" revert
"
function s:P4Revert()
python << EOF
import vim, P4, types
from datetime import datetime
p4 = P4.P4()
p4.prog = "VIM Integration"
P4Exception = P4.P4Exception
try:
    p4.connect()
    p4.tagged = False
    out = p4.run("revert", vim.current.buffer.name)
    if not (isinstance(out, types.NoneType)):
        for s in out:
            print s
    p4.disconnect()
    vim.command("edit")

except P4Exception:
    for e in p4.errors:
        print e
    for w in p4.warnings:
        print w
EOF
endfunction

"
" open for add
"
function s:P4Add()
python << EOF
import vim, P4, types
p4 = P4.P4()
p4.prog = "VIM Integration"
P4Exception = P4.P4Exception
try:
    p4.connect()
    p4.tagged = False
    out = p4.run("add", vim.current.buffer.name)
    if not (isinstance(out, types.NoneType)):
        for s in out:
            print s
    p4.disconnect()
    vim.command("edit")

except P4Exception:
    for e in p4.errors:
        print e
    for w in p4.warnings:
        print w
EOF
endfunction

"
" open for delete
"
function s:P4Delete()
python << EOF
import vim, P4, types
p4 = P4.P4()
p4.prog = "VIM Integration"
P4Exception = P4.P4Exception
try:
    p4.connect()
    p4.tagged = False
    out = p4.run("delete", vim.current.buffer.name)
    if not (isinstance(out, types.NoneType)):
        for s in out:
            print s
    p4.disconnect()
    print "File opened for delete and removed from workspace - Vim buffer no longer valid"

except P4Exception:
    for e in p4.errors:
        print e
    for w in p4.warnings:
        print w
EOF
endfunction

"
" submit a single file
"
function s:P4Submit()
    let desc = inputdialog( "Enter changelist description", "")
python << EOF
import vim, P4, types
p4 = P4.P4()
p4.prog = "VIM Integration"
P4Exception = P4.P4Exception
try:
    p4.connect()
    p4.tagged = False
    out = p4.run("submit", "-d", vim.eval("desc"), vim.current.buffer.name)
    if not (isinstance(out, types.NoneType)):
        for s in out:
            print s
    p4.disconnect()
    vim.command("edit")

except P4Exception:
    for e in p4.errors:
        print e
    for w in p4.warnings:
        print w
EOF
endfunction

"
" sync to head
"
function s:P4Sync()
python << EOF
import vim, P4, types
p4 = P4.P4()
p4.prog = "VIM Integration"
P4Exception = P4.P4Exception
try:
    p4.connect()
    p4.tagged = False
    out = p4.run("sync", vim.current.buffer.name)
    if not (isinstance(out, types.NoneType)):
        for s in out:
            print s
    p4.disconnect()
    vim.command("edit")

except P4Exception:
    for e in p4.errors:
        print e
    for w in p4.warnings:
        print w
EOF
endfunction

"
" annotate
"
function s:P4Annotate()
python << EOF
import vim, P4, types
p4 = P4.P4()
p4.prog = "VIM Integration"
P4Exception = P4.P4Exception
try:
    p4.connect()
    p4.tagged = False
    out = p4.run("annotate", vim.current.buffer.name)
    if not (isinstance(out, types.NoneType)):
        for s in out:
            print s
    p4.disconnect()

except P4Exception:
    for e in p4.errors:
        print e
    for w in p4.warnings:
        print w
EOF
endfunction

"
" list branches owned by current user
"
function s:P4Branches()
python << EOF
import vim, P4, types
p4 = P4.P4()
p4.prog = "VIM Integration"
P4Exception = P4.P4Exception
try:
    p4.connect()
    p4.tagged = True
    info = p4.run("info")
    username = info[0]['userName']
    out = p4.run("branches", "-u", username)
    if not (isinstance(out, types.NoneType)):
        print "{0:<25}description".format('branch')
        for m in out:
            print "{0:<25}{1}".format(m['branch'],m['Description'])
    p4.disconnect()

except P4Exception:
    for e in p4.errors:
        print e
    for w in p4.warnings:
        print w
EOF
endfunction

"
" connection info
"
function s:P4Info()
python << EOF
import vim, P4, types
p4 = P4.P4()
p4.prog = "VIM Integration"
P4Exception = P4.P4Exception
try:
    p4.connect()
    p4.tagged = False
    out = p4.run("info")
    if not (isinstance(out, types.NoneType)):
        for s in out:
            print s
    p4.disconnect()

except P4Exception:
    for e in p4.errors:
        print e
    for w in p4.warnings:
        print w
EOF
endfunction

"
" display branch mapping
"
function s:P4Branch()
    let branch = inputdialog( "Enter branch name", "")
python << EOF
import vim, P4, types
p4 = P4.P4()
p4.prog = "VIM Integration"
P4Exception = P4.P4Exception
try:
    p4.connect()
    p4.tagged = True
    out = p4.run("branch", "-o", vim.eval("branch")) 
    if not (isinstance(out, types.NoneType)):
        m = out[0]
        print m['Branch']
        print m['Description']
        for s in m['View']:
            print s
    p4.disconnect()

except P4Exception:
    for e in p4.errors:
        print e
    for w in p4.warnings:
        print w
EOF
endfunction

"
" display changelist info
"
function s:P4Change()
    let change = inputdialog( "Enter changelist number", "")
python << EOF
import vim, P4, types
from datetime import datetime
p4 = P4.P4()
p4.prog = "VIM Integration"
P4Exception = P4.P4Exception
try:
    p4.connect()
    p4.tagged = True
    out = p4.run("describe", "-s", vim.eval("change")) 
    if not (isinstance(out, types.NoneType)):
        m = out[0]
        timeobj = datetime.fromtimestamp(float(m['time']))
        timestr = timeobj.strftime('%Y/%m/%d')
        print "Change {0} on {1} by {2} ({3})".format(m['change'],timestr,m['user'],m['status'])
        print m['desc']
        for i in range(len(m['depotFile'])):
            print "{0:<15}{1}#{2}".format(m['action'][i],m['depotFile'][i],m['rev'][i])
    p4.disconnect()

except P4Exception:
    for e in p4.errors:
        print e
    for w in p4.warnings:
        print w
EOF
endfunction

"
" display changelists for current file
"
function s:P4Changes()
python << EOF
import vim, P4, types
from datetime import datetime
p4 = P4.P4()
p4.prog = "VIM Integration"
P4Exception = P4.P4Exception
try:
    p4.connect()
    p4.tagged = True
    out = p4.run("changes", vim.current.buffer.name)
    if not (isinstance(out, types.NoneType)):
        print "{0:<10}{1:<15}{2:<15}{3}".format('change','date','user','description')
        for m in out:
            timeobj = datetime.fromtimestamp(float(m['time']))
            timestr = timeobj.strftime('%Y/%m/%d')
            print "{0:<10}{1:<15}{2:<15}{3}".format(m['change'],timestr,m['user'],m['desc'])
    p4.disconnect()

except P4Exception:
    for e in p4.errors:
        print e
    for w in p4.warnings:
        print w
EOF
endfunction

"
" display workspace data
"
function s:P4Client()
python << EOF
import vim, P4, types
p4 = P4.P4()
p4.prog = "VIM Integration"
P4Exception = P4.P4Exception
try:
    p4.connect()
    p4.tagged = True
    out = p4.run("client", "-o")
    if not (isinstance(out, types.NoneType)):
        m = out[0]
        print "Client      : %s" % m['Client']
        print "Root        : %s" % m['Root']
        print "Options     : {0}, {1}".format(m['Options'],m['SubmitOptions'])
        print "Line endings: %s" % m['LineEnd']
        print m['Description']
        for s in m['View']:
            print s
    p4.disconnect()

except P4Exception:
    for e in p4.errors:
        print e
    for w in p4.warnings:
        print w
EOF
endfunction

"
" list workspaces owned by current user
"
function s:P4Clients()
python << EOF
import vim, P4, types
p4 = P4.P4()
p4.prog = "VIM Integration"
P4Exception = P4.P4Exception
try:
    p4.connect()
    p4.tagged = True
    info = p4.run("info")
    username = info[0]['userName']
    out = p4.run("clients", "-u", username)
    if not (isinstance(out, types.NoneType)):
        print "{0:<25}description".format('client')
        for m in out:
            print "{0:<25}{1}".format(m['client'],m['Description'])
    p4.disconnect()

except P4Exception:
    for e in p4.errors:
        print e
    for w in p4.warnings:
        print w
EOF
endfunction

"
" counters
"
function s:P4Counters()
python << EOF
import vim, P4, types
p4 = P4.P4()
p4.prog = "VIM Integration"
P4Exception = P4.P4Exception
try:
    p4.connect()
    p4.tagged = True
    out = p4.run("counters")
    if not (isinstance(out, types.NoneType)):
        print "{0:<20}{1:<20}".format("counter","value")
        for m in out:
            print "{0:<20}{1:<20}".format(m['counter'],m['value'])
    p4.disconnect()

except P4Exception:
    for e in p4.errors:
        print e
    for w in p4.warnings:
        print w
EOF
endfunction

"
" database schema
"
function s:P4Dbschema()
python << EOF
import vim, P4, types
p4 = P4.P4()
p4.prog = "VIM Integration"
P4Exception = P4.P4Exception
try:
    p4.connect()
    p4.tagged = True
    out = p4.run("dbschema")
    if not (isinstance(out, types.NoneType)):
        print "{0:<20}{1:<20}".format("table","version")
        for m in out:
            print "{0:<20}{1:<20}".format(m['table'],m['version'])
            print "{0:<5}{1:<20}{2:<15}{3:<15}{4:<15}".format('','name','type','dmtype','fmtkind')
            for i in range(len(m['name'])):
                print "{0:<5}{1:<20}{2:<15}{3:<15}{4:<15}".format('',m['name'][i],m['type'][i],m['dmtype'][i],m['fmtkind'][i])
    p4.disconnect()

except P4Exception:
    for e in p4.errors:
        print e
    for w in p4.warnings:
        print w
EOF
endfunction

"
" database stats
"
function s:P4Depots()
python << EOF
import vim, P4, types
p4 = P4.P4()
p4.prog = "VIM Integration"
P4Exception = P4.P4Exception
try:
    p4.connect()
    p4.tagged = True
    out = p4.run("depots")
    if not (isinstance(out, types.NoneType)):
        print "{0:<20}{1:<10}{2:<20}{3}".format("depot","type","map","description")
        for m in out:
            print "{0:<20}{1:<10}{2:<20}{3}".format(m['name'],m['type'],m['map'],m['desc'])
    p4.disconnect()

except P4Exception:
    for e in p4.errors:
        print e
    for w in p4.warnings:
        print w
EOF
endfunction

"
" depot list
"
function s:P4Dbstat()
python << EOF
import vim, P4, types
p4 = P4.P4()
p4.prog = "VIM Integration"
P4Exception = P4.P4Exception
try:
    p4.connect()
    p4.tagged = False
    out = p4.run("dbstat","-a")
    if not (isinstance(out, types.NoneType)):
        for s in out:
            print s.replace("\t","    ")
    out = p4.run("dbstat","-s")
    if not (isinstance(out, types.NoneType)):
        for s in out:
            print s
    p4.disconnect()

except P4Exception:
    for e in p4.errors:
        print e
    for w in p4.warnings:
        print w
EOF
endfunction

"
" diff
"
function s:P4Diff()
python << EOF
import vim, P4, types
p4 = P4.P4()
p4.prog = "VIM Integration"
P4Exception = P4.P4Exception
try:
    p4.connect()
    p4.tagged = False
    out = p4.run("diff", vim.current.buffer.name)
    if not (isinstance(out, types.NoneType)):
        for s in out:
            print s.replace("\t","    ")
    p4.disconnect()

except P4Exception:
    for e in p4.errors:
        print e
    for w in p4.warnings:
        print w
EOF
endfunction

"
" diff2
"
function s:P4Diff2()
    let rev = inputdialog( "Enter revision to diff against head", "")
python << EOF
import vim, P4, types
from datetime import datetime
p4 = P4.P4()
p4.prog = "VIM Integration"
P4Exception = P4.P4Exception
try:
    p4.connect()
    p4.tagged = False
    out = p4.run("diff2", vim.current.buffer.name + "#" + vim.eval("rev"), vim.current.buffer.name + "#head")
    if not (isinstance(out, types.NoneType)):
        for s in out:
            print s.replace("\t","    ")
    p4.disconnect()

except P4Exception:
    for e in p4.errors:
        print e
    for w in p4.warnings:
        print w
EOF
endfunction

"
" fix job
"
function s:P4Fix()
    let change = inputdialog( "Enter changelist number", "")
    let job = inputdialog( "Enter job ID", "")
python << EOF
import vim, P4, types
p4 = P4.P4()
p4.prog = "VIM Integration"
P4Exception = P4.P4Exception
try:
    p4.connect()
    p4.tagged = False
    out = p4.run("fix", "-c", vim.eval("change"), vim.eval("job"))
    if not (isinstance(out, types.NoneType)):
        for s in out:
            print s.replace("\t","    ")
    p4.disconnect()

except P4Exception:
    for e in p4.errors:
        print e
    for w in p4.warnings:
        print w
EOF
endfunction

"
" fixes for job
"
function s:P4Fixes()
    let job = inputdialog( "Enter job ID", "")
python << EOF
import vim, P4, types
p4 = P4.P4()
p4.prog = "VIM Integration"
P4Exception = P4.P4Exception
try:
    p4.connect()
    p4.tagged = False
    out = p4.run("fixes", "-j", vim.eval("job"))
    if not (isinstance(out, types.NoneType)):
        for s in out:
            print s.replace("\t","    ")
    p4.disconnect()

except P4Exception:
    for e in p4.errors:
        print e
    for w in p4.warnings:
        print w
EOF
endfunction

"
" where
"
function s:P4Where()
python << EOF
import vim, P4, types
p4 = P4.P4()
p4.prog = "VIM Integration"
P4Exception = P4.P4Exception
try:
    p4.connect()
    p4.tagged = True
    out = p4.run("where", vim.current.buffer.name)
    if not (isinstance(out, types.NoneType)):
        m = out[0]
        print "{0:<15}{1}".format("Depot path",m['depotFile'])
        print "{0:<15}{1}".format("Client path",m['clientFile'])
        print "{0:<15}{1}".format("Local path",m['path'])
    p4.disconnect()

except P4Exception:
    for e in p4.errors:
        print e
    for w in p4.warnings:
        print w
EOF
endfunction

"
" command help
"
function s:P4Help()
    let topic = inputdialog( "Help on?", "")
python << EOF
import vim, P4, types
p4 = P4.P4()
p4.prog = "VIM Integration"
P4Exception = P4.P4Exception
try:
    p4.connect()
    p4.tagged = False
    out = p4.run("help", vim.eval("topic"))
    if not (isinstance(out, types.NoneType)):
        for s in out:
            print s.replace("\t","    ")
    p4.disconnect()

except P4Exception:
    for e in p4.errors:
        print e
    for w in p4.warnings:
        print w
EOF
endfunction

"
" verify
"
function s:P4Verify()
python << EOF
import vim, P4, types
p4 = P4.P4()
p4.prog = "VIM Integration"
P4Exception = P4.P4Exception
try:
    p4.connect()
    p4.tagged = True
    out = p4.run("verify", vim.current.buffer.name)
    if not (isinstance(out, types.NoneType)):
        print "{0:<5}{1:<15}{2:<10}{3:<12}{4:<15}{5}".format('rev','action','change','type','status','depot path')
    	for m in out:
            status = 'OK'
            if 'status' in m:
                status = m['status']
            print "{0:<5}{1:<15}{2:<10}{3:<12}{4:<15}{5}".format(m['rev'],m['action'],m['change'],m['type'],status,m['depotFile'])
    p4.disconnect()

except P4Exception:
    for e in p4.errors:
        print e
    for w in p4.warnings:
        print w
EOF
endfunction

"
" display user data
"
function s:P4User()
python << EOF
import vim, P4, types
p4 = P4.P4()
p4.prog = "VIM Integration"
P4Exception = P4.P4Exception
try:
    p4.connect()
    p4.tagged = True
    out = p4.run("user", "-o")
    if not (isinstance(out, types.NoneType)):
        m = out[0]
        print "user        : %s" % m['User']
        print "Email       : %s" % m['Email']
        print "FullName    : {0}".format(m['FullName'])
        if 'JobView' in m:
            print "JobView     : {0}".format(m['JobView'])
        if 'Reviews' in m:
            print "Reviews     :"
            for s in m['Reviews']:
                print "    %s" % s
    p4.disconnect()

except P4Exception:
    for e in p4.errors:
        print e
    for w in p4.warnings:
        print w
EOF
endfunction

"
" display user list
"
function s:P4Users()
python << EOF
import vim, P4, types
p4 = P4.P4()
p4.prog = "VIM Integration"
P4Exception = P4.P4Exception
try:
    p4.connect()
    p4.tagged = True
    out = p4.run("users")
    if not (isinstance(out, types.NoneType)):
        print "{0:<20}{1:<30}{2}".format('User','Email','Name')
        for m in out:
            print "{0:<20}{1:<30}{2}".format(m['User'],m['Email'],m['FullName'])
    p4.disconnect()

except P4Exception:
    for e in p4.errors:
        print e
    for w in p4.warnings:
        print w
EOF
endfunction

"
" lock
"
function s:P4Lock()
python << EOF
import vim, P4, types
p4 = P4.P4()
p4.prog = "VIM Integration"
P4Exception = P4.P4Exception
try:
    p4.connect()
    p4.tagged = False
    out = p4.run("lock", vim.current.buffer.name)
    if not (isinstance(out, types.NoneType)):
        for s in out:
            print s
    p4.disconnect()

except P4Exception:
    for e in p4.errors:
        print e
    for w in p4.warnings:
        print w
EOF
endfunction

"
" unlock
"
function s:P4Unlock()
python << EOF
import vim, P4, types
p4 = P4.P4()
p4.prog = "VIM Integration"
P4Exception = P4.P4Exception
try:
    p4.connect()
    p4.tagged = False
    out = p4.run("unlock", vim.current.buffer.name)
    if not (isinstance(out, types.NoneType)):
        for s in out:
            print s
    p4.disconnect()

except P4Exception:
    for e in p4.errors:
        print e
    for w in p4.warnings:
        print w
EOF
endfunction

"
" print
"
function s:P4Print()
    let rev = inputdialog( "Enter revision to print", "")
python << EOF
import vim, P4, types
from datetime import datetime
p4 = P4.P4()
p4.prog = "VIM Integration"
P4Exception = P4.P4Exception
try:
    p4.connect()
    p4.tagged = False
    out = p4.run("print", "-q", vim.current.buffer.name + "#" + vim.eval("rev"))
    if not (isinstance(out, types.NoneType)):
        for s in out:
            print s.replace("\t","    ")
    p4.disconnect()

except P4Exception:
    for e in p4.errors:
        print e
    for w in p4.warnings:
        print w
EOF
endfunction

"
" opened files
"
function s:P4Opened()
python << EOF
import vim, P4, types
p4 = P4.P4()
p4.prog = "VIM Integration"
P4Exception = P4.P4Exception
try:
    p4.connect()
    p4.tagged = True
    out = p4.run("opened")
    if not (isinstance(out, types.NoneType)):
        print "{0:<40}{1:<10}{2:<12}{3:<10}".format('depotFile','rev','action','change')
        for m in out:
            print "{0:<40}{1:<10}{2:<12}{3:<10}".format(m['depotFile'],m['rev'],m['action'],m['change'])
    p4.disconnect()

except P4Exception:
    for e in p4.errors:
        print e
    for w in p4.warnings:
        print w
EOF
endfunction

"
" display group info
"
function s:P4Group()
    let group = inputdialog( "Enter group name", "")
python << EOF
import vim, P4, types
p4 = P4.P4()
p4.prog = "VIM Integration"
P4Exception = P4.P4Exception
try:
    p4.connect()
    p4.tagged = True
    out = p4.run("group", "-o", vim.eval("group")) 
    if not (isinstance(out, types.NoneType)):
        m = out[0]
        print m['Group']
        print "{0:<15}{1}".format("MaxResults",m['MaxResults'])
        print "{0:<15}{1}".format("MaxScanRows",m['MaxScanRows'])
        print "{0:<15}{1}".format("MaxLockTime",m['MaxLockTime'])
        print "{0:<15}{1}".format("Timeout",m['Timeout'])
        if 'Subgroups' in m:
            print "{0:<15}".format("Subgroups")
            for s in m['Subgroups']:
                print "{0:<5}{1}".format("",s)
        if 'Users' in m:
            print "{0:<15}".format("Users")
            for s in m['Users']:
                print "{0:<5}{1}".format("",s)
    p4.disconnect()

except P4Exception:
    for e in p4.errors:
        print e
    for w in p4.warnings:
        print w
EOF
endfunction

"
" list groups for current user
"
function s:P4Groups()
python << EOF
import vim, P4, types
p4 = P4.P4()
p4.prog = "VIM Integration"
P4Exception = P4.P4Exception
try:
    p4.connect()
    p4.tagged = True
    info = p4.run("info")
    username = info[0]['userName']
    out = p4.run("groups", username)
    if not (isinstance(out, types.NoneType)):
        print "{0:<25}{1:<15}{2:<15}{3:<15}{4:<15}".format('group','maxResults','maxScanRows','maxLockTime','timeout')
        for m in out:
            print "{0:<25}{1:<15}{2:<15}{3:<15}{4:<15}".format(m['group'],m['maxResults'],m['maxScanRows'],m['maxLockTime'],m['timeout'])
    p4.disconnect()

except P4Exception:
    for e in p4.errors:
        print e
    for w in p4.warnings:
        print w
EOF
endfunction

"
" grep
"
function s:P4Grep()
    let pattern = inputdialog( "Grep for", "")
    let path = inputdialog( "Grep where", "")
python << EOF
import vim, P4, types
p4 = P4.P4()
p4.prog = "VIM Integration"
P4Exception = P4.P4Exception
try:
    p4.connect()
    p4.tagged = True
    out = p4.run("grep", "-e", vim.eval("pattern"), vim.eval("path"))
    if not (isinstance(out, types.NoneType)):
        print "{0:<40}{1:<10}{2}".format('depotFile','rev','matchedLine')
        for m in out:
            print "{0:<40}{1:<10}{2}".format(m['depotFile'],m['rev'],m['matchedLine'].replace("\t","    "))
    p4.disconnect()

except P4Exception:
    for e in p4.errors:
        print e
    for w in p4.warnings:
        print w
EOF
endfunction

"
" integrated
"
function s:P4Integrated()
python << EOF
import vim, P4, types
from datetime import datetime
p4 = P4.P4()
p4.prog = "VIM Integration"
P4Exception = P4.P4Exception
try:
    p4.connect()
    p4.tagged = False
    out = p4.run("integrated", vim.current.buffer.name)
    if not (isinstance(out, types.NoneType)):
    	for s in out:
            print s
    p4.disconnect()

except P4Exception:
    for e in p4.errors:
        print e
    for w in p4.warnings:
        print w
EOF
endfunction

"
" display job info
"
function s:P4Job()
    let job = inputdialog( "Enter job ID", "")
python << EOF
import vim, P4, types
p4 = P4.P4()
p4.prog = "VIM Integration"
P4Exception = P4.P4Exception
try:
    p4.connect()
    p4.tagged = True
    out = p4.run("job", "-o", vim.eval("job")) 
    if not (isinstance(out, types.NoneType)):
        m = out[0]
        print m['Job'] + " (" + m['Status'] + ")"
        print "    " + m['Description']
    p4.disconnect()

except P4Exception:
    for e in p4.errors:
        print e
    for w in p4.warnings:
        print w
EOF
endfunction

"
" display job list
"
function s:P4Jobs()
    let jobview = inputdialog( "Enter job query", "")
python << EOF
import vim, P4, types
p4 = P4.P4()
p4.prog = "VIM Integration"
P4Exception = P4.P4Exception
try:
    p4.connect()
    p4.tagged = True
    out = p4.run("jobs", "-e", vim.eval("jobview")) 
    if not (isinstance(out, types.NoneType)):
        for m in out:
            print m['Job'] + " (" + m['Status'] + ")    " + m['Description']
    p4.disconnect()

except P4Exception:
    for e in p4.errors:
        print e
    for w in p4.warnings:
        print w
EOF
endfunction

"
" job spec
"
function s:P4Jobspec()
python << EOF
import vim, P4, types
p4 = P4.P4()
p4.prog = "VIM Integration"
P4Exception = P4.P4Exception
try:
    p4.connect()
    p4.tagged = False
    out = p4.run("jobspec", "-o")
    if not (isinstance(out, types.NoneType)):
        for s in out:
            print s.replace("\t","    ")
    p4.disconnect()

except P4Exception:
    for e in p4.errors:
        print e
    for w in p4.warnings:
        print w
EOF
endfunction

"
" display label info
"
function s:P4Label()
    let label = inputdialog( "Enter label name", "")
python << EOF
import vim, P4, types
p4 = P4.P4()
p4.prog = "VIM Integration"
P4Exception = P4.P4Exception
try:
    p4.connect()
    p4.tagged = True
    out = p4.run("label", "-o", vim.eval("label")) 
    if not (isinstance(out, types.NoneType)):
        m = out[0]
        print m['Label'] + " (" + m['Options'] + ")"
        if 'Revision' in m:
            print "Revision: %s" % m['Revision']
        print "  " + m['Description']
        for s in m['View']:
            print "    " + s
    p4.disconnect()

except P4Exception:
    for e in p4.errors:
        print e
    for w in p4.warnings:
        print w
EOF
endfunction

"
" display label list
"
function s:P4Labels()
python << EOF
import vim, P4, types
p4 = P4.P4()
p4.prog = "VIM Integration"
P4Exception = P4.P4Exception
try:
    p4.connect()
    p4.tagged = True
    out = p4.run("labels", vim.current.buffer.name)
    if not (isinstance(out, types.NoneType)):
        print "{0:<25}{1:<15}description".format('label','options')
        for m in out:
            print "{0:<25}{1:<15}{2}".format(m['label'],m['Options'],m['Description'])
    p4.disconnect()

except P4Exception:
    for e in p4.errors:
        print e
    for w in p4.warnings:
        print w
EOF
endfunction

"
" plugin help
"
function s:PluginHelp()
python << EOF
print("P4Python.vim: Vim plugin for Perforce, based on P4Python API")
print("Uses Perforce environment from current working directory")
print("Perforce and P4Python are copyright Perforce Software, Inc.")
print("Available commands:")
print("{0:<4}{1:<15}{2}".format("","PluginHelp","See this message"))
print("{0:<4}{1:<15}{2}".format("","P4Add","Add current file to Perforce"))
print("{0:<4}{1:<15}{2}".format("","P4Annotate","Revision annotations for current file"))
print("{0:<4}{1:<15}{2}".format("","P4Attribute","Set a file attribute"))
print("{0:<4}{1:<15}{2}".format("","P4Attributes","List file attributes"))
print("{0:<4}{1:<15}{2}".format("","P4Branch","See information about one branch spec"))
print("{0:<4}{1:<15}{2}".format("","P4Branches","List branches owned by current user"))
print("{0:<4}{1:<15}{2}".format("","P4Change","See information about one changelist"))
print("{0:<4}{1:<15}{2}".format("","P4Changes","See information about all changelists affecting current file"))
print("{0:<4}{1:<15}{2}".format("","P4Client","Current workspace information"))
print("{0:<4}{1:<15}{2}".format("","P4Clients","List workspaces owned by current user"))
print("{0:<4}{1:<15}{2}".format("","P4Counters","List system counters"))
print("{0:<4}{1:<15}{2}".format("","P4Dbschema","Database schema information"))
print("{0:<4}{1:<15}{2}".format("","P4Dbstat","Database statistics"))
print("{0:<4}{1:<15}{2}".format("","P4Delete","Delete current file"))
print("{0:<4}{1:<15}{2}".format("","P4Depots","List all depots"))
print("{0:<4}{1:<15}{2}".format("","P4Diff","Diff current file against have revision"))
print("{0:<4}{1:<15}{2}".format("","P4Diff2","Diff two revisions of current file"))
print("{0:<4}{1:<15}{2}".format("","P4Edit","Open current file for edit"))
print("{0:<4}{1:<15}{2}".format("","P4Filelog","See history of current file"))
print("{0:<4}{1:<15}{2}".format("","P4Fix","Fix a job"))
print("{0:<4}{1:<15}{2}".format("","P4Fixes","List fix records for a job"))
print("{0:<4}{1:<15}{2}".format("","P4Fstat","Get current file information"))
print("{0:<4}{1:<15}{2}".format("","P4Grep","Search in Perforce files"))
print("{0:<4}{1:<15}{2}".format("","P4Group","Information on one group"))
print("{0:<4}{1:<15}{2}".format("","P4Groups","List groups for current user"))
print("{0:<4}{1:<15}{2}".format("","P4Help","Perforce help for a command"))
print("{0:<4}{1:<15}{2}".format("","P4Info","Perforce connection information"))
print("{0:<4}{1:<15}{2}".format("","P4Integrated","Integration records for current file"))
print("{0:<4}{1:<15}{2}".format("","P4Job","Information on one job"))
print("{0:<4}{1:<15}{2}".format("","P4Jobs","List jobs that match a job query"))
print("{0:<4}{1:<15}{2}".format("","P4Jobspec","Perforce jobspec information"))
print("{0:<4}{1:<15}{2}".format("","P4Label","Information on one label"))
print("{0:<4}{1:<15}{2}".format("","P4Labels","List labels for current file"))
print("{0:<4}{1:<15}{2}".format("","P4License","Perforce license information"))
print("{0:<4}{1:<15}{2}".format("","P4Lock","Lock current file"))
print("{0:<4}{1:<15}{2}".format("","P4Lockstat","Database lock information"))
print("{0:<4}{1:<15}{2}".format("","P4Logstat","Log information"))
print("{0:<4}{1:<15}{2}".format("","P4Logtail","Log tail"))
print("{0:<4}{1:<15}{2}".format("","P4Monitor","Process monitor"))
print("{0:<4}{1:<15}{2}".format("","P4Obliterate","Obliterate preview"))
print("{0:<4}{1:<15}{2}".format("","P4Opened","See files open in current workspace"))
print("{0:<4}{1:<15}{2}".format("","P4Print","Print a revision of the current file"))
print("{0:<4}{1:<15}{2}".format("","P4Protect","Protections table"))
print("{0:<4}{1:<15}{2}".format("","P4Protects","User protections"))
print("{0:<4}{1:<15}{2}".format("","P4ReopenChange","Reopen to different changelist"))
print("{0:<4}{1:<15}{2}".format("","P4ReopenType","Reopen to different file type"))
print("{0:<4}{1:<15}{2}".format("","P4Resolve","Resolve automatically"))
print("{0:<4}{1:<15}{2}".format("","P4Resolved","Resolve status"))
print("{0:<4}{1:<15}{2}".format("","P4Revert","Revert current file"))
print("{0:<4}{1:<15}{2}".format("","P4RevGraph","Show revision graph with integration points"))
print("{0:<4}{1:<15}{2}".format("","P4Run","Run any command"))
print("{0:<4}{1:<15}{2}".format("","P4Set","Environment information"))
print("{0:<4}{1:<15}{2}".format("","P4Shelve","Shelve current file in changelist"))
print("{0:<4}{1:<15}{2}".format("","P4ShelveRemove","Remove current file from shelved changelist"))
print("{0:<4}{1:<15}{2}".format("","P4Sizes","File size for each revision of current file"))
print("{0:<4}{1:<15}{2}".format("","P4Submit","Submit current file"))
print("{0:<4}{1:<15}{2}".format("","P4Sync","Get head revision of current file"))
print("{0:<4}{1:<15}{2}".format("","P4Tag","Label current file"))
print("{0:<4}{1:<15}{2}".format("","P4Tickets","Tickets for current user"))
print("{0:<4}{1:<15}{2}".format("","P4Triggers","Trigger table"))
print("{0:<4}{1:<15}{2}".format("","P4Tunables","Tunables"))
print("{0:<4}{1:<15}{2}".format("","P4Typemap","Typemap table"))
print("{0:<4}{1:<15}{2}".format("","P4Unlock","Unlock current file"))
print("{0:<4}{1:<15}{2}".format("","P4Unshelve","Unshelve current file from changelist"))
print("{0:<4}{1:<15}{2}".format("","P4User","User profile"))
print("{0:<4}{1:<15}{2}".format("","P4Users","List all users"))
print("{0:<4}{1:<15}{2}".format("","P4Verify","Verify current file"))
print("{0:<4}{1:<15}{2}".format("","P4Where","See depot and local path for current file"))
EOF
endfunction

"
" environment info
"
function s:P4Set()
python << EOF
import vim, P4, types
p4 = P4.P4()
p4.prog = "VIM Integration"
P4Exception = P4.P4Exception
try:
    p4.connect()
    print p4.identify()
    env_vars = ["P4AUDIT","P4CHARSET","P4COMMANDCHARSET","P4CLIENT","P4CONFIG","P4DEBUG","P4DESCRIPTION","P4DIFF","P4DIFFUNICODE","P4EDITOR","P4HOST","P4JOURNAL","P4LANGUAGE","P4LOG","P4MERGE","P4MERGEUNICODE","P4NAME","P4PAGER","P4PASSWD","P4PORT","P4TARGET","P4TICKETS","P4USER","P4ZEROCONF","PWD","TMP","TEMP"]
    for e in env_vars:
        print("{0:<4}{1:<20}{2}".format("",e,p4.env(e)))
    p4.disconnect()

except P4Exception:
    for e in p4.errors:
        print e
    for w in p4.warnings:
        print w
EOF
endfunction

"
" sizes
"
function s:P4Sizes()
python << EOF
import vim, P4, types
p4 = P4.P4()
p4.prog = "VIM Integration"
P4Exception = P4.P4Exception
try:
    p4.connect()
    p4.tagged = True
    out = p4.run("sizes", "-a", vim.current.buffer.name)
    if not (isinstance(out, types.NoneType)):
        print "{0:<5}{1}".format('rev','fileSize (KB)') 
        for m in out:
            fsize = "%.1f" % (float(m['fileSize']) / 1024.0)
            print "{0:<5}{1}".format(m['rev'],fsize) 
    p4.disconnect()

except P4Exception:
    for e in p4.errors:
        print e
    for w in p4.warnings:
        print w
EOF
endfunction

"
" tag a single file
"
function s:P4Tag()
    let label = inputdialog( "Enter label name", "")
python << EOF
import vim, P4, types
p4 = P4.P4()
p4.prog = "VIM Integration"
P4Exception = P4.P4Exception
try:
    p4.connect()
    p4.tagged = False
    out = p4.run("tag", "-l", vim.eval("label"), vim.current.buffer.name)
    if not (isinstance(out, types.NoneType)):
        for s in out:
            print s
    p4.disconnect()

except P4Exception:
    for e in p4.errors:
        print e
    for w in p4.warnings:
        print w
EOF
endfunction

"
" license info
"
function s:P4License()
python << EOF
import vim, P4, types
p4 = P4.P4()
p4.prog = "VIM Integration"
P4Exception = P4.P4Exception
try:
    p4.connect()
    p4.tagged = False
    out = p4.run("license", "-o")
    if not (isinstance(out, types.NoneType)):
        for s in out:
            print s.replace("\t","    ")
    p4.disconnect()

except P4Exception:
    for e in p4.errors:
        print e
    for w in p4.warnings:
        print w
EOF
endfunction

"
" db lock info
"
function s:P4Lockstat()
python << EOF
import vim, P4, types
p4 = P4.P4()
p4.prog = "VIM Integration"
P4Exception = P4.P4Exception
try:
    p4.connect()
    p4.tagged = False
    out = p4.run("lockstat")
    if not (isinstance(out, types.NoneType)):
        for s in out:
            print s.replace("\t","    ")
    p4.disconnect()

except P4Exception:
    for e in p4.errors:
        print e
    for w in p4.warnings:
        print w
EOF
endfunction

"
" log info
"
function s:P4Logstat()
python << EOF
import vim, P4, types
p4 = P4.P4()
p4.prog = "VIM Integration"
P4Exception = P4.P4Exception
try:
    p4.connect()
    p4.tagged = False
    out = p4.run("logstat")
    if not (isinstance(out, types.NoneType)):
        for s in out:
            print s.replace("\t","    ")
    p4.disconnect()

except P4Exception:
    for e in p4.errors:
        print e
    for w in p4.warnings:
        print w
EOF
endfunction

"
" log tail
"
function s:P4Logtail()
python << EOF
import vim, P4, types
p4 = P4.P4()
p4.prog = "VIM Integration"
P4Exception = P4.P4Exception
try:
    p4.connect()
    p4.tagged = False
    out = p4.run("logtail")
    if not (isinstance(out, types.NoneType)):
        print out[0]['file']
        print out[0]['data'].replace("\t","    ")
    p4.disconnect()

except P4Exception:
    for e in p4.errors:
        print e
    for w in p4.warnings:
        print w
EOF
endfunction

"
" monitor
"
function s:P4Monitor()
python << EOF
import vim, P4, types
p4 = P4.P4()
p4.prog = "VIM Integration"
P4Exception = P4.P4Exception
try:
    p4.connect()
    p4.tagged = True
    out = p4.run("monitor", "show")
    if not (isinstance(out, types.NoneType)):
        print("{0:<10}{1:<10}{2:<20}{3:<15}{4}".format('id','status','user','time','command'))
        for m in out:
            print("{0:<10}{1:<10}{2:<20}{3:<15}{4}".format(m['id'],m['status'],m['user'],m['time'],m['command']))
    p4.disconnect()

except P4Exception:
    for e in p4.errors:
        print e
    for w in p4.warnings:
        print w
EOF
endfunction

"
" obliterate
"
function s:P4Obliterate()
python << EOF
import vim, P4, types
p4 = P4.P4()
p4.prog = "VIM Integration"
P4Exception = P4.P4Exception
try:
    p4.connect()
    p4.tagged = True
    out = p4.run("obliterate", vim.current.buffer.name)
    if not (isinstance(out, types.NoneType)):
        print("PREVIEW MODE")
        for m in out:
            if 'clientRecDeleted' in m:
                print("{0:<5}{1}".format(m['clientRecDeleted'], "client records deleted"))
            if 'labelRecDeleted' in m:
                print("{0:<5}{1}".format(m['labelRecDeleted'], "label records deleted"))
            if 'integrationRecDeleted' in m:
                print("{0:<5}{1}".format(m['integrationRecDeleted'], "integration records deleted"))
            if 'workingRecDeleted' in m:
                print("{0:<5}{1}".format(m['workingRecDeleted'], "working records deleted"))
            if 'revisionRecDeleted' in m:
                print("{0:<5}{1}".format(m['revisionRecDeleted'], "revision records deleted"))
            if 'purgeFile' in m:
                print('Purged ' + m['purgeFile'] + '#' +  m['purgeRev'])
    p4.disconnect()

except P4Exception:
    for e in p4.errors:
        print e
    for w in p4.warnings:
        print w
EOF
endfunction

"
" display protetions data
"
function s:P4Protects()
python << EOF
import vim, P4, types
p4 = P4.P4()
p4.prog = "VIM Integration"
P4Exception = P4.P4Exception
try:
    p4.connect()
    p4.tagged = True
    out = p4.run("protects")
    if not (isinstance(out, types.NoneType)):
        print("{0:<15}{1:<20}{2:<20}{3}".format('Permission','User or group','Host','Path'))
        for m in out:
            who = ''
            if 'user' in m:
                who = m['user']
            if 'group' in m:
                who = m['group']
            print("{0:<15}{1:<20}{2:<20}{3}".format(m['perm'],who,m['host'],m['depotFile']))
    p4.disconnect()

except P4Exception:
    for e in p4.errors:
        print e
    for w in p4.warnings:
        print w
EOF
endfunction

"
" protections table
"
function s:P4Protect()
python << EOF
import vim, P4, types
p4 = P4.P4()
p4.prog = "VIM Integration"
P4Exception = P4.P4Exception
try:
    p4.connect()
    p4.tagged = False
    out = p4.run("protect", "-o")
    if not (isinstance(out, types.NoneType)):
        for s in out:
            print s.replace("\t","    ")
    p4.disconnect()

except P4Exception:
    for e in p4.errors:
        print e
    for w in p4.warnings:
        print w
EOF
endfunction

"
" reopen to changelist
"
function s:P4ReopenChange()
    let change = inputdialog( "Enter changelist number", "")
python << EOF
import vim, P4, types
from datetime import datetime
p4 = P4.P4()
p4.prog = "VIM Integration"
P4Exception = P4.P4Exception
try:
    p4.connect()
    p4.tagged = False
    out = p4.run("reopen", "-c", vim.eval("change"), vim.current.buffer.name) 
    if not (isinstance(out, types.NoneType)):
        for s in out:
            print s.replace("\t","    ")
    p4.disconnect()
    vim.command("edit")

except P4Exception:
    for e in p4.errors:
        print e
    for w in p4.warnings:
        print w
EOF
endfunction

"
" reopen file type
"
function s:P4ReopenType()
    let type = inputdialog( "Enter file type", "")
python << EOF
import vim, P4, types
p4 = P4.P4()
p4.prog = "VIM Integration"
P4Exception = P4.P4Exception
try:
    p4.connect()
    p4.tagged = False
    out = p4.run("reopen", "-t", vim.eval("type"), vim.current.buffer.name) 
    if not (isinstance(out, types.NoneType)):
        for s in out:
            print s.replace("\t","    ")
    p4.disconnect()
    vim.command("edit")

except P4Exception:
    for e in p4.errors:
        print e
    for w in p4.warnings:
        print w
EOF
endfunction

"
" resolve
"
function s:P4Resolve()
    let accept = inputdialog( "Enter accept resolve option", "")
python << EOF
import vim, P4, types
accept = vim.eval("accept")
if accept == '-am' or accept == '-af' or accept == '-as' or accept == '-at' or accept == '-ay':
    p4 = P4.P4()
    p4.prog = "VIM Integration"
    P4Exception = P4.P4Exception
    try:
        p4.connect()
        p4.tagged = False
        out = p4.run("resolve", accept, vim.current.buffer.name) 
        if not (isinstance(out, types.NoneType)):
            for s in out:
                print s.replace("\t","    ")
        p4.disconnect()
        vim.command("edit")

    except P4Exception:
        for e in p4.errors:
            print e
        for w in p4.warnings:
            print w
else:
    print("Error: you must select one of -am/-af/-as/-at/-ay")
EOF
endfunction

"
" resolve status
"
function s:P4Resolved()
python << EOF
import vim, P4, types
p4 = P4.P4()
p4.prog = "VIM Integration"
P4Exception = P4.P4Exception
try:
    p4.connect()
    p4.tagged = True
    out = p4.run("resolved", vim.current.buffer.name) 
    if not (isinstance(out, types.NoneType)):
        m = out[0]
        print("{0:<40}{1:<15}{2}{3},{4}".format(m['toFile'],m['how'],m['fromFile'],m['startFromRev'],m['endFromRev']))
    p4.disconnect()

except P4Exception:
    for e in p4.errors:
        print e
    for w in p4.warnings:
        print w
EOF
endfunction

"
" trigger table
"
function s:P4Triggers()
python << EOF
import vim, P4, types
p4 = P4.P4()
p4.prog = "VIM Integration"
P4Exception = P4.P4Exception
try:
    p4.connect()
    p4.tagged = False
    out = p4.run("triggers", "-o")
    if not (isinstance(out, types.NoneType)):
        for s in out:
            print s.replace("\t","    ")
    p4.disconnect()

except P4Exception:
    for e in p4.errors:
        print e
    for w in p4.warnings:
        print w
EOF
endfunction

"
" typemap table
"
function s:P4Typemap()
python << EOF
import vim, P4, types
p4 = P4.P4()
p4.prog = "VIM Integration"
P4Exception = P4.P4Exception
try:
    p4.connect()
    p4.tagged = False
    out = p4.run("typemap", "-o")
    if not (isinstance(out, types.NoneType)):
        for s in out:
            print s.replace("\t","    ")
    p4.disconnect()

except P4Exception:
    for e in p4.errors:
        print e
    for w in p4.warnings:
        print w
EOF
endfunction

"
" tickets
"
function s:P4Tickets()
python << EOF
import vim, P4, types
p4 = P4.P4()
p4.prog = "VIM Integration"
P4Exception = P4.P4Exception
try:
    p4.connect()
    p4.tagged = False
    out = p4.run("tickets")
    if not (isinstance(out, types.NoneType)):
        for s in out:
            print s.replace("\t","    ")
    p4.disconnect()

except P4Exception:
    for e in p4.errors:
        print e
    for w in p4.warnings:
        print w
EOF
endfunction

"
" tunables
"
function s:P4Tunables()
python << EOF
import vim, P4, types
p4 = P4.P4()
p4.prog = "VIM Integration"
P4Exception = P4.P4Exception
try:
    p4.connect()
    p4.tagged = False
    out = p4.run("tunables", "-a")
    if not (isinstance(out, types.NoneType)):
        for s in out:
            print s.replace("\t","    ")
    p4.disconnect()

except P4Exception:
    for e in p4.errors:
        print e
    for w in p4.warnings:
        print w
EOF
endfunction

"
" set attribute
"
function s:P4Attribute()
    let attrib = inputdialog( "Attribute name", "")
    let value = inputdialog( "Enter value", "")
python << EOF
import vim, P4, types
p4 = P4.P4()
p4.prog = "VIM Integration"
P4Exception = P4.P4Exception
try:
    p4.connect()
    p4.tagged = False
    out = p4.run("attribute", "-n", vim.eval("attrib"), "-v", vim.eval("value"), vim.current.buffer.name)
    if not (isinstance(out, types.NoneType)):
        for s in out:
            print s.replace("\t","    ")
    p4.disconnect()

except P4Exception:
    for e in p4.errors:
        print e
    for w in p4.warnings:
        print w
EOF
endfunction

"
" attribute list
"
function s:P4Attributes()
python << EOF
import vim, P4, types
p4 = P4.P4()
p4.prog = "VIM Integration"
P4Exception = P4.P4Exception
try:
    p4.connect()
    p4.tagged = True
    out = p4.run("fstat", "-Oa", vim.current.buffer.name)
    if not (isinstance(out, types.NoneType)):
        m = out[0]
        print("{0:<30}{1}".format("Name","Value"))
        for key in iter(m):
            if key.find("attr-") == 0:
                print("{0:<30}{1}".format(key[5:],m[key]))
            if key.find("openattr-") == 0:
                print("{0:<30}{1}".format(key[9:],m[key]))
        
    p4.disconnect()

except P4Exception:
    for e in p4.errors:
        print e
    for w in p4.warnings:
        print w
EOF
endfunction

"
" run any command
"
function s:P4Run()
    let cmd = inputdialog( "Enter complete command to run, without the leading 'p4'", "")
python << EOF
import vim, P4, types
p4 = P4.P4()
p4.prog = "VIM Integration"
P4Exception = P4.P4Exception
try:
    p4.connect()
    p4.tagged = False
    out = p4.run(vim.eval("cmd").split())
    if not (isinstance(out, types.NoneType)):
        for s in out:
            print s
    p4.disconnect()

except P4Exception:
    for e in p4.errors:
        print e
    for w in p4.warnings:
        print w
EOF
endfunction

"
" shelve
"
function s:P4Shelve()
    let change = inputdialog( "Enter changelist number", "")
python << EOF
import vim, P4, types
p4 = P4.P4()
p4.prog = "VIM Integration"
P4Exception = P4.P4Exception
try:
    p4.connect()
    p4.tagged = False
    out = p4.run("reopen", "-c", vim.eval("change"), vim.current.buffer.name)
    out = p4.run("shelve", "-c", vim.eval("change"), "-f", vim.current.buffer.name)
    if not (isinstance(out, types.NoneType)):
        for s in out:
            print s
    p4.disconnect()
    vim.command("edit")

except P4Exception:
    for e in p4.errors:
        print e
    for w in p4.warnings:
        print w
EOF
endfunction

"
" remove from shelf
"
function s:P4ShelveRemove()
    let change = inputdialog( "Enter changelist number", "")
python << EOF
import vim, P4, types
p4 = P4.P4()
p4.prog = "VIM Integration"
P4Exception = P4.P4Exception
try:
    p4.connect()
    p4.tagged = False
    out = p4.run("shelve", "-d", "-c", vim.eval("change"), "-f", vim.current.buffer.name)
    if not (isinstance(out, types.NoneType)):
        for s in out:
            print s
    p4.disconnect()

except P4Exception:
    for e in p4.errors:
        print e
    for w in p4.warnings:
        print w
EOF
endfunction

"
" unshelve
"
function s:P4Unshelve()
    let change = inputdialog( "Enter changelist number", "")
python << EOF
import vim, P4, types
p4 = P4.P4()
p4.prog = "VIM Integration"
P4Exception = P4.P4Exception
try:
    p4.connect()
    p4.tagged = False
    out = p4.run("unshelve", "-s", vim.eval("change"), vim.current.buffer.name)
    if not (isinstance(out, types.NoneType)):
        for s in out:
            print s
    p4.disconnect()
    vim.command("edit")

except P4Exception:
    for e in p4.errors:
        print e
    for w in p4.warnings:
        print w
EOF
endfunction

"
" ASCII rev graph
"
function s:P4RevGraph()
python << EOF
import vim, P4, types
from datetime import datetime
p4 = P4.P4()
p4.prog = "VIM Integration"
P4Exception = P4.P4Exception
try:
    p4.connect()
    p4.tagged = True
    out = p4.run("integrated", vim.current.buffer.name)
    if not (isinstance(out, types.NoneType)):
        graph = ''
    	for m in out:
            # current file always listed as 'to file'
            how = m['how']
            if how.find("into") != -1 or how.find("ignored by") != -1:
                toFile = m['fromFile']
                fromFile = m['toFile']
                startToRev = m['startFromRev']
                endToRev = m['endFromRev']
                startFromRev = m['startToRev']
                endFromRev = m['endToRev']
            else:
                toFile = m['toFile']
                fromFile = m['fromFile']
                startToRev = m['startToRev']
                endToRev = m['endToRev']
                startFromRev = m['startFromRev']
                endFromRev = m['endFromRev']
            change = m['change']
            graph = graph + fromFile + endFromRev + '@' + toFile + endToRev + '@change ' + change + ' ' + how + "|"
        if graph == '':
            graph = 'NONE'
        vim.command("let b:graph = \"%s\"" % graph)
    else:
        print("No integration records")
        vim.command("let b:graph = \"NONE\"")
    p4.disconnect()

except P4Exception:
    vim.command("let b:graph = \"NONE\"")
    for e in p4.errors:
        print e
    for w in p4.warnings:
        print w
EOF
perl << EOF
use Graph::Easy; 
my @gstr = VIM::Eval('b:graph');
if($gstr[1] ne '' and $gstr[1] ne 'NONE') {
    my @parts = split(/\|/, $gstr[1]);
    my $graph = Graph::Easy->new();
    foreach my $pair (@parts) {
        my @p = split(/@/,$pair);
        $graph->add_node($p[0]);
        $graph->add_node($p[1]);
        $graph->add_edge($p[0],$p[1],$p[2]);
    }
    VIM::Msg($graph->as_ascii());
}
EOF
endfunction

