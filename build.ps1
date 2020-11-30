# Add path to MSBuild Binaries
Do {
    if (Test-Path "${Env:Programfiles(x86)}\Microsoft Visual Studio\2017\Community\MSBuild\15.0\Bin\msbuild.exe" -PathType leaf) {
        $MSBUILD="${Env:Programfiles(x86)}\Microsoft Visual Studio\2017\Community\MSBuild\15.0\Bin\msbuild.exe"
    }
    elseif (Test-Path "$Env:ProgramFiles\Microsoft Visual Studio\2017\Community\MSBuild\15.0\Bin\msbuild.exe" -PathType leaf) {
        $MSBUILD="$Env:ProgramFiles\Microsoft Visual Studio\2017\Community\MSBuild\15.0\Bin\msbuild.exe"
    }
    elseif (Test-Path "${Env:Programfiles(x86)}\Microsoft Visual Studio\Preview\Community\MSBuild\15.0\Bin\msbuild.exe" -PathType leaf) {
        $MSBUILD="${Env:Programfiles(x86)}\Microsoft Visual Studio\Preview\Community\MSBuild\15.0\Bin\msbuild.exe"
    }
    elseif (Test-Path "$Env:ProgramFiles\Microsoft Visual Studio\Preview\Community\MSBuild\15.0\Bin\msbuild.exe" -PathType leaf) {
        $MSBUILD="$Env:ProgramFiles\Microsoft Visual Studio\Preview\Community\MSBuild\15.0\Bin\msbuild.exe"
    }
    elseif (Test-Path "${Env:Programfiles(x86)}\Microsoft Visual Studio\2017\Professional\MSBuild\15.0\Bin\msbuild.exe" -PathType leaf) {
        $MSBUILD="${Env:Programfiles(x86)}\Microsoft Visual Studio\2017\Professional\MSBuild\15.0\Bin\msbuild.exe"
    }
    elseif (Test-Path "$Env:ProgramFiles\Microsoft Visual Studio\2017\Professional\MSBuild\15.0\Bin\msbuild.exe" -PathType leaf) {
        $MSBUILD="$Env:ProgramFiles\Microsoft Visual Studio\2017\Professional\MSBuild\15.0\Bin\msbuild.exe"
    }
    elseif (Test-Path "${Env:Programfiles(x86)}\Microsoft Visual Studio\2017\Enterprise\MSBuild\15.0\Bin\msbuild.exe" -PathType leaf) {
        $MSBUILD="${Env:Programfiles(x86)}\Microsoft Visual Studio\2017\Enterprise\MSBuild\15.0\Bin\msbuild.exe"
    }
    elseif (Test-Path "$Env:ProgramFiles\Microsoft Visual Studio\2017\Enterprise\MSBuild\15.0\Bin\msbuild.exe" -PathType leaf) {
        $MSBUILD="$Env:ProgramFiles\Microsoft Visual Studio\2017\Enterprise\MSBuild\15.0\Bin\msbuild.exe"
    }
    elseif (Test-Path "${Env:Programfiles(x86)}\Microsoft Visual Studio\2019\Preview\MSBuild\Current\Bin\MSBuild.exe" -PathType leaf) {
        $MSBUILD="${Env:Programfiles(x86)}\Microsoft Visual Studio\2019\Preview\MSBuild\Current\Bin\MSBuild.exe"
    }
    elseif (Test-Path "$Env:ProgramFiles\Microsoft Visual Studio\2019\Community\MSBuild\15.0\Bin\msbuild.exe" -PathType leaf) {
        $MSBUILD="$Env:ProgramFiles\Microsoft Visual Studio\2019\Community\MSBuild\15.0\Bin\msbuild.exe"
    }
    elseif (Test-Path "${Env:Programfiles(x86)}\Microsoft Visual Studio\2019\Community\MSBuild\Current\Bin\MSBuild.exe" -PathType leaf) {
        $MSBUILD="${Env:Programfiles(x86)}\Microsoft Visual Studio\2019\Community\MSBuild\Current\Bin\MSBuild.exe"
    }
    elseif (Test-Path "$Env:ProgramFiles\Microsoft Visual Studio\2019\Professional\MSBuild\15.0\Bin\msbuild.exe" -PathType leaf) {
        $MSBUILD="$Env:ProgramFiles\Microsoft Visual Studio\2019\Professional\MSBuild\15.0\Bin\msbuild.exe"
    }
    elseif (Test-Path "${Env:Programfiles(x86)}\Microsoft Visual Studio\2019\Professional\MSBuild\Current\Bin\MSBuild.exe" -PathType leaf) {
        $MSBUILD="${Env:Programfiles(x86)}\Microsoft Visual Studio\2019\Professional\MSBuild\Current\Bin\MSBuild.exe"
    }
    elseif (Test-Path "$Env:ProgramFiles\Microsoft Visual Studio\2019\Enterprise\MSBuild\15.0\Bin\msbuild.exe" -PathType leaf) {
        $MSBUILD="$Env:ProgramFiles\Microsoft Visual Studio\2019\Enterprise\MSBuild\15.0\Bin\msbuild.exe"
    }
    elseif (Test-Path "${Env:Programfiles(x86)}\Microsoft Visual Studio\2019\Enterprise\MSBuild\Current\Bin\MSBuild.exe" -PathType leaf) {
        $MSBUILD="${Env:Programfiles(x86)}\Microsoft Visual Studio\2019\Enterprise\MSBuild\Current\Bin\MSBuild.exe"
    }
    elseif (Test-Path "${Env:Programfiles(x86)}\MSBuild\14.0\bin") {
        $MSBUILD="${Env:Programfiles(x86)}\MSBuild\14.0\bin\msbuild.exe"
    }
    elseif (Test-Path "$Env:ProgramFiles\MSBuild\14.0\bin") {
        $MSBUILD="$Env:ProgramFiles\MSBuild\14.0\bin\msbuild.exe"
    }
    else {
        Write-Host "I couldn't find MSBuild on your PC. Make sure it's installed somewhere, and if it's not in the above if statements (in build.ps1), add it."
        exit
    }
}
Until ($MSBUILD)

$_MSBUILD_TARGET="Build"
$_MSBUILD_CONFIG="Debug"
$_MSBUILD_PLATFORM="x64"
$_MSBUILD_APPX_BUNDLE_PLATFORMS="x64|ARM64"

for ( $i = 0; $i -lt $args.count; $i++ ) {
    if ($args[$i] -eq "") {
        return "DONE"
    }
    if ($args[$i] -eq "clean") {
        $_MSBUILD_TARGET="Clean,Build"
    }
    if ($args[$i] -eq "rel") {
        $_MSBUILD_CONFIG="Release"
    }
    if ($args[$i] -eq "x64") {
        $_MSBUILD_PLATFORM="x64"
        $_MSBUILD_APPX_BUNDLE_PLATFORMS="x64"
    }
    if ($args[$i] -eq "ARM64") {
        $_MSBUILD_PLATFORM="ARM64"
        $_MSBUILD_APPX_BUNDLE_PLATFORMS="ARM64"
    }
}

$slnPath = Join-Path $PSScriptRoot "DistroLauncher.sln" 
& $MSBUILD $slnPath /t:${_MSBUILD_TARGET} /m /nr:true `
    /p:Configuration=${_MSBUILD_CONFIG} `
    /p:Platform=${_MSBUILD_PLATFORM} `
    /p:AppxBundlePlatforms=${_MSBUILD_APPX_BUNDLE_PLATFORMS} `
    /p:"UseSubFolderForOutputDirDuringMultiPlatformBuild=false"

if($?) {
    Write-Host "`nCreated appx in ${PSScriptRoot}\AppPackages\DistroLauncher-Appx\`n"
}
