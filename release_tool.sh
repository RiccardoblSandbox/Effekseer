if [ "$RDIR" = "" ];
then
    export RDIR="$PWD/EffekseerToolLinux"
fi




rmdir $RDIR
mkdir -p $RDIR

echo Compile Editor

echo Copy application

cp -Rv Dev/release $RDIR/Tool
rm -R $RDIR/Tool/linux-x64 || true
rm -R $RDIR/Tool/publish || true

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

