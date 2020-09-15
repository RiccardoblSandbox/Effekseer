
if [ "`which robocopy`" = "" ];
then
    function robocopy { 
        from=$1
        to=$2 
        include=""
        echo "cp -v from $from to $to"
        args=(${@:3})
        unset "args[${#args[@]}-1]" 

        for i in "${args[@]}"; 
        do 
            include="$include --include=\"$i\""
            echo "Include $i"
            
        done
        
        rsync -av --exclude=\"*\" $include $from $to

    }

fi



RDIR="$PWD/EffekseerTool"


rmdir $RDIR
mkdir -p $RDIR

echo Compile Editor

echo Copy application

mkdir -p $RDIR/Tool

cp -v Dev/release/Effekseer.exe $RDIR/Tool/. || cp -v Dev/release/Effekseer $RDIR/Tool/.
cp -v Dev/release/Effekseer.exe.config $RDIR/Tool/. || cp -v Dev/release/Effekseer.config $RDIR/Tool/. || true
cp -v Dev/release/EffekseerCore.dll $RDIR/Tool/.
cp -v Dev/release/EffekseerViewer.dll $RDIR/Tool/. || true
cp -v Dev/release/IronPython.dll $RDIR/Tool/.
cp -v Dev/release/IronPython.Modules.dll $RDIR/Tool/.
cp -v Dev/release/Microsoft.Dynamic.dll $RDIR/Tool/.
cp -v Dev/release/Microsoft.Scripting.dll $RDIR/Tool/.
cp -v Dev/release/EffekseerMaterialEditor$EXE_EXT $RDIR/Tool/.
cp -v Dev/release/Viewer.dll $RDIR/Tool/. || true
cp -v Dev/release/Newtonsoft.Json.dll $RDIR/Tool/.


mkdir -p $RDIR/Tool/scripts
mkdir -p $RDIR/Tool/scripts/export
cp -v Dev/release/scripts/export/Default.cs $RDIR/Tool/scripts/export/.

mkdir -p $RDIR/Tool/tools
cp -v Dev/release/tools/fbxToEffekseerModelConverter.exe $RDIR/Tool/tools/. || true
cp -v Dev/release/tools/mqoToEffekseerModelConverter.exe $RDIR/Tool/tools/.|| true

cp -v Dev/release/tools/EffekseerMaterialCompilerDX9.dll $RDIR/Tool/tools/.|| true
cp -v Dev/release/tools/EffekseerMaterialCompilerDX11.dll $RDIR/Tool/tools/. || true
cp -v Dev/release/tools/EffekseerMaterialCompilerDX12.dll $RDIR/Tool/tools/.|| true
cp -v Dev/release/tools/EffekseerMaterialCompilerGL.dll $RDIR/Tool/tools/. || cp -v Dev/release/tools/libEffekseerMaterialCompilerGL.so $RDIR/Tool/tools/.
cp -v Dev/release/tools/EffekseerMaterialCompilerMetal.dll $RDIR/Tool/tools/.|| cp -v Dev/release/tools/libEffekseerMaterialCompilerMetal.so $RDIR/Tool/tools/.


mkdir -p $RDIR/Tool/resources
robocopy Dev/release/resources/ $RDIR/Tool/resources/. /s

echo Sample

mkdir -p $RDIR/Sample
robocopy Release/Sample $RDIR/Sample *.efkproj *.efkmodel *.efkmat *.efkefc *.txt *.png *.mqo *.fbx /S
robocopy ResourceData/samples $RDIR/Sample *.efkproj *.efkmodel *.efkmat *.efkefc *.txt *.png *.mqo *.fbx /S

echo Readme
cp -v readme_tool_win.txt $RDIR/readme.txt
cp -v docs/readme_sample.txt $RDIR/Sample/readme.txt

cp -v docs/Help_Ja.html $RDIR/Help_Ja.html
cp -v docs/Help_En.html $RDIR/Help_En.html
cp -v LICENSE_TOOL $RDIR/LICENSE_TOOL

