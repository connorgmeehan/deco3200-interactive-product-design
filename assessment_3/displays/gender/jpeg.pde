/*
  a simple jpeg encoder / decoder class
  based on java standard libraries.
  
  USAGE:
  
  byte[] b = compressJpg(img,0.5);  
  PImage imgCompressed = decompressImage(b);
  
  0.0 100% compression
  1.0 0% compression
  
*/


  
import java.awt.image.BufferedImage;

import javax.imageio.plugins.jpeg.*;
import javax.imageio.*;
import javax.imageio.stream.*;

import java.util.Iterator;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;


import java.awt.image.BufferedImage;

byte[] compressJpg(PImage img, float compressionQuality)
{
  byte[] compressed;

  JPEGImageWriteParam jpegParams = new JPEGImageWriteParam(null);
  jpegParams.setCompressionMode(ImageWriteParam.MODE_EXPLICIT);
  jpegParams.setCompressionQuality(1f);

  // copy image into a buffered image
  BufferedImage out = new BufferedImage(img.width, img.height, BufferedImage.TYPE_INT_RGB);
  for (int i=0; i<img.pixels.length; i++) {
    out.setRGB(i % img.width, i/img.width, img.pixels[i]);
  }
  
   try {
  
  // prepare a byte array stream to receive the jpg data
  ByteArrayOutputStream buffer = new ByteArrayOutputStream();
  ImageOutputStream buffer2 = ImageIO.createImageOutputStream(buffer);


  Iterator<ImageWriter> iter = ImageIO.getImageWritersByFormatName("jpeg");
    ImageWriter writer = iter.next();
    ImageWriteParam iwp = writer.getDefaultWriteParam();
    iwp.setCompressionMode(ImageWriteParam.MODE_EXPLICIT);
    iwp.setCompressionQuality(compressionQuality);
    writer.setOutput(buffer2);
    
    
    writer.write(null, new IIOImage(out,null,null),iwp);
    writer.dispose();
  
  
    buffer.flush();
    byte[] bytesOut = buffer.toByteArray();
  buffer.close();
    return bytesOut;
   } 
  catch (Exception e) {
    System.out.println(e);
  }    
  
    return null;
}

/* 
     i suppose this should work with any image
 */

PImage decompressImage(byte[] compressedImage) {
  try {  
    // make a buffered image.
    ByteArrayInputStream bufferIn = new ByteArrayInputStream(compressedImage);  
    BufferedImage in  = ImageIO.read(bufferIn);

    // prepare a processing image
    PImage imageOut = new PImage( in.getWidth(null), in.getHeight(null));
    imageOut.loadPixels();

    // copy pixels
    for (int x=0; x< in.getWidth(null); x++ ) {
      for (int y=0; y< in.getHeight(null); y++ ) {
        int rgb = in.getRGB(x, y);
        imageOut.pixels[y*in.getWidth(null)+x] = rgb;
      }
    }
    return imageOut;
  } 
  catch (Exception e) {
    System.out.println(e);
  }
  return null;
}
