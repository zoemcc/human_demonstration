module Paths_ROS_Demo (
    version,
    getBinDir, getLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
catchIO = Exception.catch


version :: Version
version = Version {versionBranch = [0,0], versionTags = []}
bindir, libdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "bin"
libdir     = "/home/zoe/.cabal/lib/x86_64-linux-ghc-7.6.3/ROS-Demo-0.0"
datadir    = "/home/zoe/.cabal/share/x86_64-linux-ghc-7.6.3/ROS-Demo-0.0"
libexecdir = "/home/zoe/.cabal/libexec"
sysconfdir = "/home/zoe/.cabal/etc"

getBinDir, getLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "ROS_Demo_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "ROS_Demo_libdir") (\_ -> return libdir)
getDataDir = catchIO (getEnv "ROS_Demo_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "ROS_Demo_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "ROS_Demo_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
