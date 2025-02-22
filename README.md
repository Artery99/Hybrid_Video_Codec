# Hybrid Video Codec (MATLAB Implementation)

# Overview
This project implements a Hybrid Video Codec using block-based Discrete Cosine Transform (DCT), motion estimation, quantization, and entropy coding for efficient video compression. It combines intra-frame (spatial) and inter-frame (temporal) compression to achieve high compression efficiency while maintaining video quality.

The codec follows a Group of Pictures (GOP) structure, where:

I-frames (keyframes) are compressed using DCT, quantization, and entropy coding.
P-frames (intermediate frames) utilize motion estimation and compensation to reduce redundancy across frames.
Rate-Distortion Optimization selects the best encoding strategy based on bitrate vs. quality trade-offs.
The system also includes bitstream encoding and decoding, enabling compressed video storage and reconstruction using inverse DCT, dequantization, and motion compensation. The efficiency of the codec is assessed using Rate-Distortion (RD) analysis, which plots bitrate vs. Mean Squared Error (MSE) or PSNR.

# Key Features
✅ Block-based DCT Compression
✅ Quantization & Entropy Coding (RLC, Huffman Coding)
✅ Motion Estimation & Compensation
✅ Bitstream Encoding & Decoding
✅ Rate-Distortion Analysis

MATLAB (DCT, Motion Estimation, Quantization, Entropy Coding)
