{-# LANGUAGE NamedFieldPuns #-}
module Demo (demo) where
import Ros.Node
import qualified Ros.Std_msgs.Header  as H --(Header(..), seq, stamp, frame_id)
import Ros.Sensor_msgs.Image (Image(..), header, width, height, encoding, is_bigendian, step, _data)
import qualified Data.Vector.Storable as V
import Data.Array.Repa hiding ((++))
import qualified Data.Array.Repa.Repr.ForeignPtr as RFP
import qualified Data.Array.Repa.IO.DevIL as IL
import Data.Word
import Foreign.Ptr
import qualified Foreign.ForeignPtr.Safe         as FPS

--saveImg :: Header -> IO ()
saveImg :: Image -> IO ()
--saveImg im = do
saveImg (Image {header, width, height, encoding, is_bigendian, step, _data}) = do --{width, height, encoding, _data}
    putStrLn "Image received"
    --r <- V.unsafeWith _data (ptr2repa (fromEnum width) (fromEnum height))
    --IL.runIL $ IL.writeImage "test.png" (IL.Grey r)
    return ()
--  | encoding == "mono8" = maybe noPt showPt p 
 -- | otherwise = putStrLn "Unsupported image format"
 --
saveHeader :: H.Header -> IO ()
saveHeader (H.Header {H.seq, H.stamp, H.frame_id}) = do 
    putStrLn "Header received: "
    putStrLn ("Seq: " ++ show H.seq ++ " Stamp: " ++ show H.stamp) -- ++ " frame_id: " ++ show H.frame_id)

ptr2repa :: Int -> Int -> Ptr Word8 -> IO (Array RFP.F DIM2 Word8)
ptr2repa width height p = do
    fp <- FPS.newForeignPtr_ p
    return $ RFP.fromForeignPtr (Z :. width :. height) fp

demo :: Node ()
demo = subscribe "/camera/depth/image_rect" >>= runHandler saveImg >> return ()

