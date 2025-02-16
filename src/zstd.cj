// cjbind 0.1.9 生成，请勿编辑, DO NOT EDIT

package zstd

// ZDICT_trainFromBuffer():
//  Train a dictionary from an array of samples.
//  Redirect towards ZDICT_optimizeTrainFromBuffer_fastCover() single-threaded, with d=8, steps=4,
//  f=20, and accel=1.
//  Samples must be stored concatenated in a single flat buffer `samplesBuffer`,
//  supplied with an array of sizes `samplesSizes`, providing the size of each sample, in order.
//  The resulting dictionary will be saved into `dictBuffer`.
// @return: size of dictionary stored into `dictBuffer` (<= `dictBufferCapacity`)
//          or an error code, which can be tested with ZDICT_isError().
//  Note:  Dictionary training will fail if there are not enough samples to construct a
//         dictionary, or if most of the samples are too small (< 8 bytes being the lower limit).
//         If dictionary training fails, you should use zstd without a dictionary, as the dictionary
//         would've been ineffective anyways. If you believe your samples would benefit from a dictionary
//         please open an issue with details, and we can look into it.
//  Note: ZDICT_trainFromBuffer()'s memory usage is about 6 MB.
//  Tips: In general, a reasonable dictionary has a size of ~ 100 KB.
//        It's possible to select smaller or larger size, just by specifying `dictBufferCapacity`.
//        In general, it's recommended to provide a few thousands samples, though this can vary a lot.
//        It's recommended that total size of all samples be about ~x100 times the target size of dictionary.
foreign func ZDICT_trainFromBuffer(dictBuffer: CPointer<Unit>, dictBufferCapacity: UIntNative,
    samplesBuffer: CPointer<Unit>, samplesSizes: CPointer<UIntNative>, nbSamples: UInt32): UIntNative

// ZDICT_trainFromBuffer():
//  Train a dictionary from an array of samples.
//  Redirect towards ZDICT_optimizeTrainFromBuffer_fastCover() single-threaded, with d=8, steps=4,
//  f=20, and accel=1.
//  Samples must be stored concatenated in a single flat buffer `samplesBuffer`,
//  supplied with an array of sizes `samplesSizes`, providing the size of each sample, in order.
//  The resulting dictionary will be saved into `dictBuffer`.
// @return: size of dictionary stored into `dictBuffer` (<= `dictBufferCapacity`)
//          or an error code, which can be tested with ZDICT_isError().
//  Note:  Dictionary training will fail if there are not enough samples to construct a
//         dictionary, or if most of the samples are too small (< 8 bytes being the lower limit).
//         If dictionary training fails, you should use zstd without a dictionary, as the dictionary
//         would've been ineffective anyways. If you believe your samples would benefit from a dictionary
//         please open an issue with details, and we can look into it.
//  Note: ZDICT_trainFromBuffer()'s memory usage is about 6 MB.
//  Tips: In general, a reasonable dictionary has a size of ~ 100 KB.
//        It's possible to select smaller or larger size, just by specifying `dictBufferCapacity`.
//        In general, it's recommended to provide a few thousands samples, though this can vary a lot.
//        It's recommended that total size of all samples be about ~x100 times the target size of dictionary.
public func ZDICT_trainFromBuffer_wrapper(dictBuffer: CPointer<Unit>, dictBufferCapacity: UIntNative,
    samplesBuffer: CPointer<Unit>, samplesSizes: CPointer<UIntNative>, nbSamples: UInt32): UIntNative {
    unsafe { return ZDICT_trainFromBuffer(dictBuffer, dictBufferCapacity, samplesBuffer, samplesSizes, nbSamples) }
}

@C
public struct ZDICT_params_t {
    //< optimize for a specific zstd compression level; 0 means default
    public let compressionLevel: Int32
    //< Write log to stderr; 0 = none (default); 1 = errors; 2 = progression; 3 = details; 4 = debug;
    public let notificationLevel: UInt32
    //< force dictID value; 0 means auto mode (32-bits random value)
    //   NOTE: The zstd format reserves some dictionary IDs for future use.
    //         You may use them in private settings, but be warned that they
    //         may be used by zstd in a public dictionary registry in the future.
    //         These dictionary IDs are:
    //           - low range  : <= 32767
    //           - high range : >= (2^31)
    public let dictID: UInt32

    init(compressionLevel: Int32, notificationLevel: UInt32, dictID: UInt32) {
        this.compressionLevel = compressionLevel
        this.notificationLevel = notificationLevel
        this.dictID = dictID
    }
}

// ZDICT_finalizeDictionary():
// Given a custom content as a basis for dictionary, and a set of samples,
// finalize dictionary by adding headers and statistics according to the zstd
// dictionary format.
//
// Samples must be stored concatenated in a flat buffer `samplesBuffer`,
// supplied with an array of sizes `samplesSizes`, providing the size of each
// sample in order. The samples are used to construct the statistics, so they
// should be representative of what you will compress with this dictionary.
//
// The compression level can be set in `parameters`. You should pass the
// compression level you expect to use in production. The statistics for each
// compression level differ, so tuning the dictionary for the compression level
// can help quite a bit.
//
// You can set an explicit dictionary ID in `parameters`, or allow us to pick
// a random dictionary ID for you, but we can't guarantee no collisions.
//
// The dstDictBuffer and the dictContent may overlap, and the content will be
// appended to the end of the header. If the header + the content doesn't fit in
// maxDictSize the beginning of the content is truncated to make room, since it
// is presumed that the most profitable content is at the end of the dictionary,
// since that is the cheapest to reference.
//
// `maxDictSize` must be >= max(dictContentSize, ZDICT_DICTSIZE_MIN).
//
// @return: size of dictionary stored into `dstDictBuffer` (<= `maxDictSize`),
//          or an error code, which can be tested by ZDICT_isError().
// Note: ZDICT_finalizeDictionary() will push notifications into stderr if
//       instructed to, using notificationLevel>0.
// NOTE: This function currently may fail in several edge cases including:
//         * Not enough samples
//         * Samples are uncompressible
//         * Samples are all exactly the same
foreign func ZDICT_finalizeDictionary(dstDictBuffer: CPointer<Unit>, maxDictSize: UIntNative,
    dictContent: CPointer<Unit>, dictContentSize: UIntNative, samplesBuffer: CPointer<Unit>,
    samplesSizes: CPointer<UIntNative>, nbSamples: UInt32, parameters: ZDICT_params_t): UIntNative

// ZDICT_finalizeDictionary():
// Given a custom content as a basis for dictionary, and a set of samples,
// finalize dictionary by adding headers and statistics according to the zstd
// dictionary format.
//
// Samples must be stored concatenated in a flat buffer `samplesBuffer`,
// supplied with an array of sizes `samplesSizes`, providing the size of each
// sample in order. The samples are used to construct the statistics, so they
// should be representative of what you will compress with this dictionary.
//
// The compression level can be set in `parameters`. You should pass the
// compression level you expect to use in production. The statistics for each
// compression level differ, so tuning the dictionary for the compression level
// can help quite a bit.
//
// You can set an explicit dictionary ID in `parameters`, or allow us to pick
// a random dictionary ID for you, but we can't guarantee no collisions.
//
// The dstDictBuffer and the dictContent may overlap, and the content will be
// appended to the end of the header. If the header + the content doesn't fit in
// maxDictSize the beginning of the content is truncated to make room, since it
// is presumed that the most profitable content is at the end of the dictionary,
// since that is the cheapest to reference.
//
// `maxDictSize` must be >= max(dictContentSize, ZDICT_DICTSIZE_MIN).
//
// @return: size of dictionary stored into `dstDictBuffer` (<= `maxDictSize`),
//          or an error code, which can be tested by ZDICT_isError().
// Note: ZDICT_finalizeDictionary() will push notifications into stderr if
//       instructed to, using notificationLevel>0.
// NOTE: This function currently may fail in several edge cases including:
//         * Not enough samples
//         * Samples are uncompressible
//         * Samples are all exactly the same
public func ZDICT_finalizeDictionary_wrapper(dstDictBuffer: CPointer<Unit>, maxDictSize: UIntNative,
    dictContent: CPointer<Unit>, dictContentSize: UIntNative, samplesBuffer: CPointer<Unit>,
    samplesSizes: CPointer<UIntNative>, nbSamples: UInt32, parameters: ZDICT_params_t): UIntNative {
    unsafe { return ZDICT_finalizeDictionary(dstDictBuffer, maxDictSize, dictContent, dictContentSize, samplesBuffer,
        samplesSizes, nbSamples, parameters) }
}

foreign func ZDICT_getDictID(dictBuffer: CPointer<Unit>, dictSize: UIntNative): UInt32

public func ZDICT_getDictID_wrapper(dictBuffer: CPointer<Unit>, dictSize: UIntNative): UInt32 {
    unsafe { return ZDICT_getDictID(dictBuffer, dictSize) }
}

foreign func ZDICT_getDictHeaderSize(dictBuffer: CPointer<Unit>, dictSize: UIntNative): UIntNative

public func ZDICT_getDictHeaderSize_wrapper(dictBuffer: CPointer<Unit>, dictSize: UIntNative): UIntNative {
    unsafe { return ZDICT_getDictHeaderSize(dictBuffer, dictSize) }
}

foreign func ZDICT_isError(errorCode: UIntNative): UInt32

public func ZDICT_isError_wrapper(errorCode: UIntNative): UInt32 {
    unsafe { return ZDICT_isError(errorCode) }
}

foreign func ZDICT_getErrorName(errorCode: UIntNative): CString

public func ZDICT_getErrorName_wrapper(errorCode: UIntNative): CString {
    unsafe { return ZDICT_getErrorName(errorCode) }
}

public const ZSTD_error_no_error: ZSTD_ErrorCode = 0
public const ZSTD_error_GENERIC: ZSTD_ErrorCode = 1
public const ZSTD_error_prefix_unknown: ZSTD_ErrorCode = 10
public const ZSTD_error_version_unsupported: ZSTD_ErrorCode = 12
public const ZSTD_error_frameParameter_unsupported: ZSTD_ErrorCode = 14
public const ZSTD_error_frameParameter_windowTooLarge: ZSTD_ErrorCode = 16
public const ZSTD_error_corruption_detected: ZSTD_ErrorCode = 20
public const ZSTD_error_checksum_wrong: ZSTD_ErrorCode = 22
public const ZSTD_error_literals_headerWrong: ZSTD_ErrorCode = 24
public const ZSTD_error_dictionary_corrupted: ZSTD_ErrorCode = 30
public const ZSTD_error_dictionary_wrong: ZSTD_ErrorCode = 32
public const ZSTD_error_dictionaryCreation_failed: ZSTD_ErrorCode = 34
public const ZSTD_error_parameter_unsupported: ZSTD_ErrorCode = 40
public const ZSTD_error_parameter_combination_unsupported: ZSTD_ErrorCode = 41
public const ZSTD_error_parameter_outOfBound: ZSTD_ErrorCode = 42
public const ZSTD_error_tableLog_tooLarge: ZSTD_ErrorCode = 44
public const ZSTD_error_maxSymbolValue_tooLarge: ZSTD_ErrorCode = 46
public const ZSTD_error_maxSymbolValue_tooSmall: ZSTD_ErrorCode = 48
public const ZSTD_error_cannotProduce_uncompressedBlock: ZSTD_ErrorCode = 49
public const ZSTD_error_stabilityCondition_notRespected: ZSTD_ErrorCode = 50
public const ZSTD_error_stage_wrong: ZSTD_ErrorCode = 60
public const ZSTD_error_init_missing: ZSTD_ErrorCode = 62
public const ZSTD_error_memory_allocation: ZSTD_ErrorCode = 64
public const ZSTD_error_workSpace_tooSmall: ZSTD_ErrorCode = 66
public const ZSTD_error_dstSize_tooSmall: ZSTD_ErrorCode = 70
public const ZSTD_error_srcSize_wrong: ZSTD_ErrorCode = 72
public const ZSTD_error_dstBuffer_null: ZSTD_ErrorCode = 74
public const ZSTD_error_noForwardProgress_destFull: ZSTD_ErrorCode = 80
public const ZSTD_error_noForwardProgress_inputEmpty: ZSTD_ErrorCode = 82
public const ZSTD_error_frameIndex_tooLarge: ZSTD_ErrorCode = 100
public const ZSTD_error_seekableIO: ZSTD_ErrorCode = 102
public const ZSTD_error_dstBuffer_wrong: ZSTD_ErrorCode = 104
public const ZSTD_error_srcBuffer_wrong: ZSTD_ErrorCode = 105
public const ZSTD_error_sequenceProducer_failed: ZSTD_ErrorCode = 106
public const ZSTD_error_externalSequences_invalid: ZSTD_ErrorCode = 107
public const ZSTD_error_maxCode: ZSTD_ErrorCode = 120

public type ZSTD_ErrorCode = UInt32

foreign func ZSTD_getErrorString(code: ZSTD_ErrorCode): CString

public func ZSTD_getErrorString_wrapper(code: ZSTD_ErrorCode): CString {
    unsafe { return ZSTD_getErrorString(code) }
}

// ZSTD_versionNumber() :
//  Return runtime library version, the value is (MAJOR*100*100 + MINOR*100 + RELEASE).
foreign func ZSTD_versionNumber(): UInt32

// ZSTD_versionNumber() :
//  Return runtime library version, the value is (MAJOR*100*100 + MINOR*100 + RELEASE).
public func ZSTD_versionNumber_wrapper(): UInt32 {
    unsafe { return ZSTD_versionNumber() }
}

// ZSTD_versionString() :
//  Return runtime library version, like "1.4.5". Requires v1.3.0+.
foreign func ZSTD_versionString(): CString

// ZSTD_versionString() :
//  Return runtime library version, like "1.4.5". Requires v1.3.0+.
public func ZSTD_versionString_wrapper(): CString {
    unsafe { return ZSTD_versionString() }
}

//  Simple Core API
///
///*! ZSTD_compress() :
//  Compresses `src` content as a single zstd compressed frame into already allocated `dst`.
//  NOTE: Providing `dstCapacity >= ZSTD_compressBound(srcSize)` guarantees that zstd will have
//        enough space to successfully compress the data.
//  @return : compressed size written into `dst` (<= `dstCapacity),
//            or an error code if it fails (which can be tested using ZSTD_isError()).
foreign func ZSTD_compress(dst: CPointer<Unit>, dstCapacity: UIntNative, src: CPointer<Unit>, srcSize: UIntNative,
    compressionLevel: Int32): UIntNative

//  Simple Core API
///
///*! ZSTD_compress() :
//  Compresses `src` content as a single zstd compressed frame into already allocated `dst`.
//  NOTE: Providing `dstCapacity >= ZSTD_compressBound(srcSize)` guarantees that zstd will have
//        enough space to successfully compress the data.
//  @return : compressed size written into `dst` (<= `dstCapacity),
//            or an error code if it fails (which can be tested using ZSTD_isError()).
public func ZSTD_compress_wrapper(dst: CPointer<Unit>, dstCapacity: UIntNative, src: CPointer<Unit>,
    srcSize: UIntNative, compressionLevel: Int32): UIntNative {
    unsafe { return ZSTD_compress(dst, dstCapacity, src, srcSize, compressionLevel) }
}

// ZSTD_decompress() :
// `compressedSize` : must be the _exact_ size of some number of compressed and/or skippable frames.
//  Multiple compressed frames can be decompressed at once with this method.
//  The result will be the concatenation of all decompressed frames, back to back.
// `dstCapacity` is an upper bound of originalSize to regenerate.
//  First frame's decompressed size can be extracted using ZSTD_getFrameContentSize().
//  If maximum upper bound isn't known, prefer using streaming mode to decompress data.
// @return : the number of bytes decompressed into `dst` (<= `dstCapacity`),
//           or an errorCode if it fails (which can be tested using ZSTD_isError()).
foreign func ZSTD_decompress(dst: CPointer<Unit>, dstCapacity: UIntNative, src: CPointer<Unit>,
    compressedSize: UIntNative): UIntNative

// ZSTD_decompress() :
// `compressedSize` : must be the _exact_ size of some number of compressed and/or skippable frames.
//  Multiple compressed frames can be decompressed at once with this method.
//  The result will be the concatenation of all decompressed frames, back to back.
// `dstCapacity` is an upper bound of originalSize to regenerate.
//  First frame's decompressed size can be extracted using ZSTD_getFrameContentSize().
//  If maximum upper bound isn't known, prefer using streaming mode to decompress data.
// @return : the number of bytes decompressed into `dst` (<= `dstCapacity`),
//           or an errorCode if it fails (which can be tested using ZSTD_isError()).
public func ZSTD_decompress_wrapper(dst: CPointer<Unit>, dstCapacity: UIntNative, src: CPointer<Unit>,
    compressedSize: UIntNative): UIntNative {
    unsafe { return ZSTD_decompress(dst, dstCapacity, src, compressedSize) }
}

foreign func ZSTD_getFrameContentSize(src: CPointer<Unit>, srcSize: UIntNative): UInt64

public func ZSTD_getFrameContentSize_wrapper(src: CPointer<Unit>, srcSize: UIntNative): UInt64 {
    unsafe { return ZSTD_getFrameContentSize(src, srcSize) }
}

// ZSTD_getDecompressedSize() (obsolete):
//  This function is now obsolete, in favor of ZSTD_getFrameContentSize().
//  Both functions work the same way, but ZSTD_getDecompressedSize() blends
//  "empty", "unknown" and "error" results to the same return value (0),
//  while ZSTD_getFrameContentSize() gives them separate return values.
// @return : decompressed size of `src` frame content _if known and not empty_, 0 otherwise.
foreign func ZSTD_getDecompressedSize(src: CPointer<Unit>, srcSize: UIntNative): UInt64

// ZSTD_getDecompressedSize() (obsolete):
//  This function is now obsolete, in favor of ZSTD_getFrameContentSize().
//  Both functions work the same way, but ZSTD_getDecompressedSize() blends
//  "empty", "unknown" and "error" results to the same return value (0),
//  while ZSTD_getFrameContentSize() gives them separate return values.
// @return : decompressed size of `src` frame content _if known and not empty_, 0 otherwise.
public func ZSTD_getDecompressedSize_wrapper(src: CPointer<Unit>, srcSize: UIntNative): UInt64 {
    unsafe { return ZSTD_getDecompressedSize(src, srcSize) }
}

// ZSTD_findFrameCompressedSize() : Requires v1.4.0+
// `src` should point to the start of a ZSTD frame or skippable frame.
// `srcSize` must be >= first frame size
// @return : the compressed size of the first frame starting at `src`,
//           suitable to pass as `srcSize` to `ZSTD_decompress` or similar,
//           or an error code if input is invalid
//  Note 1: this method is called _find*() because it's not enough to read the header,
//          it may have to scan through the frame's content, to reach its end.
//  Note 2: this method also works with Skippable Frames. In which case,
//          it returns the size of the complete skippable frame,
//          which is always equal to its content size + 8 bytes for headers.
foreign func ZSTD_findFrameCompressedSize(src: CPointer<Unit>, srcSize: UIntNative): UIntNative

// ZSTD_findFrameCompressedSize() : Requires v1.4.0+
// `src` should point to the start of a ZSTD frame or skippable frame.
// `srcSize` must be >= first frame size
// @return : the compressed size of the first frame starting at `src`,
//           suitable to pass as `srcSize` to `ZSTD_decompress` or similar,
//           or an error code if input is invalid
//  Note 1: this method is called _find*() because it's not enough to read the header,
//          it may have to scan through the frame's content, to reach its end.
//  Note 2: this method also works with Skippable Frames. In which case,
//          it returns the size of the complete skippable frame,
//          which is always equal to its content size + 8 bytes for headers.
public func ZSTD_findFrameCompressedSize_wrapper(src: CPointer<Unit>, srcSize: UIntNative): UIntNative {
    unsafe { return ZSTD_findFrameCompressedSize(src, srcSize) }
}

foreign func ZSTD_compressBound(srcSize: UIntNative): UIntNative

public func ZSTD_compressBound_wrapper(srcSize: UIntNative): UIntNative {
    unsafe { return ZSTD_compressBound(srcSize) }
}

foreign func ZSTD_isError(result: UIntNative): UInt32

public func ZSTD_isError_wrapper(result: UIntNative): UInt32 {
    unsafe { return ZSTD_isError(result) }
}

foreign func ZSTD_getErrorCode(functionResult: UIntNative): ZSTD_ErrorCode

public func ZSTD_getErrorCode_wrapper(functionResult: UIntNative): ZSTD_ErrorCode {
    unsafe { return ZSTD_getErrorCode(functionResult) }
}

foreign func ZSTD_getErrorName(result: UIntNative): CString

public func ZSTD_getErrorName_wrapper(result: UIntNative): CString {
    unsafe { return ZSTD_getErrorName(result) }
}

foreign func ZSTD_minCLevel(): Int32

public func ZSTD_minCLevel_wrapper(): Int32 {
    unsafe { return ZSTD_minCLevel() }
}

foreign func ZSTD_maxCLevel(): Int32

public func ZSTD_maxCLevel_wrapper(): Int32 {
    unsafe { return ZSTD_maxCLevel() }
}

foreign func ZSTD_defaultCLevel(): Int32

public func ZSTD_defaultCLevel_wrapper(): Int32 {
    unsafe { return ZSTD_defaultCLevel() }
}

@C
public struct ZSTD_CCtx_s {
    init() {
        throw Exception("opaque type should not be inited")
    }
}

//  Explicit context
public type ZSTD_CCtx = ZSTD_CCtx_s

foreign func ZSTD_createCCtx(): CPointer<ZSTD_CCtx>

public func ZSTD_createCCtx_wrapper(): CPointer<ZSTD_CCtx> {
    unsafe { return ZSTD_createCCtx() }
}

foreign func ZSTD_freeCCtx(cctx: CPointer<ZSTD_CCtx>): UIntNative

public func ZSTD_freeCCtx_wrapper(cctx: CPointer<ZSTD_CCtx>): UIntNative {
    unsafe { return ZSTD_freeCCtx(cctx) }
}

// ZSTD_compressCCtx() :
//  Same as ZSTD_compress(), using an explicit ZSTD_CCtx.
//  Important : in order to mirror `ZSTD_compress()` behavior,
//  this function compresses at the requested compression level,
//  __ignoring any other advanced parameter__ .
//  If any advanced parameter was set using the advanced API,
//  they will all be reset. Only @compressionLevel remains.
foreign func ZSTD_compressCCtx(cctx: CPointer<ZSTD_CCtx>, dst: CPointer<Unit>, dstCapacity: UIntNative,
    src: CPointer<Unit>, srcSize: UIntNative, compressionLevel: Int32): UIntNative

// ZSTD_compressCCtx() :
//  Same as ZSTD_compress(), using an explicit ZSTD_CCtx.
//  Important : in order to mirror `ZSTD_compress()` behavior,
//  this function compresses at the requested compression level,
//  __ignoring any other advanced parameter__ .
//  If any advanced parameter was set using the advanced API,
//  they will all be reset. Only @compressionLevel remains.
public func ZSTD_compressCCtx_wrapper(cctx: CPointer<ZSTD_CCtx>, dst: CPointer<Unit>, dstCapacity: UIntNative,
    src: CPointer<Unit>, srcSize: UIntNative, compressionLevel: Int32): UIntNative {
    unsafe { return ZSTD_compressCCtx(cctx, dst, dstCapacity, src, srcSize, compressionLevel) }
}

@C
public struct ZSTD_DCtx_s {
    init() {
        throw Exception("opaque type should not be inited")
    }
}

public type ZSTD_DCtx = ZSTD_DCtx_s

foreign func ZSTD_createDCtx(): CPointer<ZSTD_DCtx>

public func ZSTD_createDCtx_wrapper(): CPointer<ZSTD_DCtx> {
    unsafe { return ZSTD_createDCtx() }
}

foreign func ZSTD_freeDCtx(dctx: CPointer<ZSTD_DCtx>): UIntNative

public func ZSTD_freeDCtx_wrapper(dctx: CPointer<ZSTD_DCtx>): UIntNative {
    unsafe { return ZSTD_freeDCtx(dctx) }
}

// ZSTD_decompressDCtx() :
//  Same as ZSTD_decompress(),
//  requires an allocated ZSTD_DCtx.
//  Compatible with sticky parameters (see below).
foreign func ZSTD_decompressDCtx(dctx: CPointer<ZSTD_DCtx>, dst: CPointer<Unit>, dstCapacity: UIntNative,
    src: CPointer<Unit>, srcSize: UIntNative): UIntNative

// ZSTD_decompressDCtx() :
//  Same as ZSTD_decompress(),
//  requires an allocated ZSTD_DCtx.
//  Compatible with sticky parameters (see below).
public func ZSTD_decompressDCtx_wrapper(dctx: CPointer<ZSTD_DCtx>, dst: CPointer<Unit>, dstCapacity: UIntNative,
    src: CPointer<Unit>, srcSize: UIntNative): UIntNative {
    unsafe { return ZSTD_decompressDCtx(dctx, dst, dstCapacity, src, srcSize) }
}

public const ZSTD_fast: ZSTD_strategy = 1
public const ZSTD_dfast: ZSTD_strategy = 2
public const ZSTD_greedy: ZSTD_strategy = 3
public const ZSTD_lazy: ZSTD_strategy = 4
public const ZSTD_lazy2: ZSTD_strategy = 5
public const ZSTD_btlazy2: ZSTD_strategy = 6
public const ZSTD_btopt: ZSTD_strategy = 7
public const ZSTD_btultra: ZSTD_strategy = 8
public const ZSTD_btultra2: ZSTD_strategy = 9

//  Advanced compression API (Requires v1.4.0+)
public type ZSTD_strategy = UInt32

public const ZSTD_c_compressionLevel: ZSTD_cParameter = 100
public const ZSTD_c_windowLog: ZSTD_cParameter = 101
public const ZSTD_c_hashLog: ZSTD_cParameter = 102
public const ZSTD_c_chainLog: ZSTD_cParameter = 103
public const ZSTD_c_searchLog: ZSTD_cParameter = 104
public const ZSTD_c_minMatch: ZSTD_cParameter = 105
public const ZSTD_c_targetLength: ZSTD_cParameter = 106
public const ZSTD_c_strategy: ZSTD_cParameter = 107
public const ZSTD_c_targetCBlockSize: ZSTD_cParameter = 130
public const ZSTD_c_enableLongDistanceMatching: ZSTD_cParameter = 160
public const ZSTD_c_ldmHashLog: ZSTD_cParameter = 161
public const ZSTD_c_ldmMinMatch: ZSTD_cParameter = 162
public const ZSTD_c_ldmBucketSizeLog: ZSTD_cParameter = 163
public const ZSTD_c_ldmHashRateLog: ZSTD_cParameter = 164
public const ZSTD_c_contentSizeFlag: ZSTD_cParameter = 200
public const ZSTD_c_checksumFlag: ZSTD_cParameter = 201
public const ZSTD_c_dictIDFlag: ZSTD_cParameter = 202
public const ZSTD_c_nbWorkers: ZSTD_cParameter = 400
public const ZSTD_c_jobSize: ZSTD_cParameter = 401
public const ZSTD_c_overlapLog: ZSTD_cParameter = 402
public const ZSTD_c_experimentalParam1: ZSTD_cParameter = 500
public const ZSTD_c_experimentalParam2: ZSTD_cParameter = 10
public const ZSTD_c_experimentalParam3: ZSTD_cParameter = 1000
public const ZSTD_c_experimentalParam4: ZSTD_cParameter = 1001
public const ZSTD_c_experimentalParam5: ZSTD_cParameter = 1002
public const ZSTD_c_experimentalParam7: ZSTD_cParameter = 1004
public const ZSTD_c_experimentalParam8: ZSTD_cParameter = 1005
public const ZSTD_c_experimentalParam9: ZSTD_cParameter = 1006
public const ZSTD_c_experimentalParam10: ZSTD_cParameter = 1007
public const ZSTD_c_experimentalParam11: ZSTD_cParameter = 1008
public const ZSTD_c_experimentalParam12: ZSTD_cParameter = 1009
public const ZSTD_c_experimentalParam13: ZSTD_cParameter = 1010
public const ZSTD_c_experimentalParam14: ZSTD_cParameter = 1011
public const ZSTD_c_experimentalParam15: ZSTD_cParameter = 1012
public const ZSTD_c_experimentalParam16: ZSTD_cParameter = 1013
public const ZSTD_c_experimentalParam17: ZSTD_cParameter = 1014
public const ZSTD_c_experimentalParam18: ZSTD_cParameter = 1015
public const ZSTD_c_experimentalParam19: ZSTD_cParameter = 1016
public const ZSTD_c_experimentalParam20: ZSTD_cParameter = 1017

public type ZSTD_cParameter = UInt32

@C
public struct ZSTD_bounds {
    public let error: UIntNative
    public let lowerBound: Int32
    public let upperBound: Int32

    init(error: UIntNative, lowerBound: Int32, upperBound: Int32) {
        this.error = error
        this.lowerBound = lowerBound
        this.upperBound = upperBound
    }
}

// ZSTD_cParam_getBounds() :
//  All parameters must belong to an interval with lower and upper bounds,
//  otherwise they will either trigger an error or be automatically clamped.
// @return : a structure, ZSTD_bounds, which contains
//         - an error status field, which must be tested using ZSTD_isError()
//         - lower and upper bounds, both inclusive
foreign func ZSTD_cParam_getBounds(cParam: ZSTD_cParameter): ZSTD_bounds

// ZSTD_cParam_getBounds() :
//  All parameters must belong to an interval with lower and upper bounds,
//  otherwise they will either trigger an error or be automatically clamped.
// @return : a structure, ZSTD_bounds, which contains
//         - an error status field, which must be tested using ZSTD_isError()
//         - lower and upper bounds, both inclusive
public func ZSTD_cParam_getBounds_wrapper(cParam: ZSTD_cParameter): ZSTD_bounds {
    unsafe { return ZSTD_cParam_getBounds(cParam) }
}

// ZSTD_CCtx_setParameter() :
//  Set one compression parameter, selected by enum ZSTD_cParameter.
//  All parameters have valid bounds. Bounds can be queried using ZSTD_cParam_getBounds().
//  Providing a value beyond bound will either clamp it, or trigger an error (depending on parameter).
//  Setting a parameter is generally only possible during frame initialization (before starting compression).
//  Exception : when using multi-threading mode (nbWorkers >= 1),
//              the following parameters can be updated _during_ compression (within same frame):
//              => compressionLevel, hashLog, chainLog, searchLog, minMatch, targetLength and strategy.
//              new parameters will be active for next job only (after a flush()).
// @return : an error code (which can be tested using ZSTD_isError()).
foreign func ZSTD_CCtx_setParameter(cctx: CPointer<ZSTD_CCtx>, param: ZSTD_cParameter, value: Int32): UIntNative

// ZSTD_CCtx_setParameter() :
//  Set one compression parameter, selected by enum ZSTD_cParameter.
//  All parameters have valid bounds. Bounds can be queried using ZSTD_cParam_getBounds().
//  Providing a value beyond bound will either clamp it, or trigger an error (depending on parameter).
//  Setting a parameter is generally only possible during frame initialization (before starting compression).
//  Exception : when using multi-threading mode (nbWorkers >= 1),
//              the following parameters can be updated _during_ compression (within same frame):
//              => compressionLevel, hashLog, chainLog, searchLog, minMatch, targetLength and strategy.
//              new parameters will be active for next job only (after a flush()).
// @return : an error code (which can be tested using ZSTD_isError()).
public func ZSTD_CCtx_setParameter_wrapper(cctx: CPointer<ZSTD_CCtx>, param: ZSTD_cParameter, value: Int32): UIntNative {
    unsafe { return ZSTD_CCtx_setParameter(cctx, param, value) }
}

// ZSTD_CCtx_setPledgedSrcSize() :
//  Total input data size to be compressed as a single frame.
//  Value will be written in frame header, unless if explicitly forbidden using ZSTD_c_contentSizeFlag.
//  This value will also be controlled at end of frame, and trigger an error if not respected.
// @result : 0, or an error code (which can be tested with ZSTD_isError()).
//  Note 1 : pledgedSrcSize==0 actually means zero, aka an empty frame.
//           In order to mean "unknown content size", pass constant ZSTD_CONTENTSIZE_UNKNOWN.
//           ZSTD_CONTENTSIZE_UNKNOWN is default value for any new frame.
//  Note 2 : pledgedSrcSize is only valid once, for the next frame.
//           It's discarded at the end of the frame, and replaced by ZSTD_CONTENTSIZE_UNKNOWN.
//  Note 3 : Whenever all input data is provided and consumed in a single round,
//           for example with ZSTD_compress2(),
//           or invoking immediately ZSTD_compressStream2(,,,ZSTD_e_end),
//           this value is automatically overridden by srcSize instead.
foreign func ZSTD_CCtx_setPledgedSrcSize(cctx: CPointer<ZSTD_CCtx>, pledgedSrcSize: UInt64): UIntNative

// ZSTD_CCtx_setPledgedSrcSize() :
//  Total input data size to be compressed as a single frame.
//  Value will be written in frame header, unless if explicitly forbidden using ZSTD_c_contentSizeFlag.
//  This value will also be controlled at end of frame, and trigger an error if not respected.
// @result : 0, or an error code (which can be tested with ZSTD_isError()).
//  Note 1 : pledgedSrcSize==0 actually means zero, aka an empty frame.
//           In order to mean "unknown content size", pass constant ZSTD_CONTENTSIZE_UNKNOWN.
//           ZSTD_CONTENTSIZE_UNKNOWN is default value for any new frame.
//  Note 2 : pledgedSrcSize is only valid once, for the next frame.
//           It's discarded at the end of the frame, and replaced by ZSTD_CONTENTSIZE_UNKNOWN.
//  Note 3 : Whenever all input data is provided and consumed in a single round,
//           for example with ZSTD_compress2(),
//           or invoking immediately ZSTD_compressStream2(,,,ZSTD_e_end),
//           this value is automatically overridden by srcSize instead.
public func ZSTD_CCtx_setPledgedSrcSize_wrapper(cctx: CPointer<ZSTD_CCtx>, pledgedSrcSize: UInt64): UIntNative {
    unsafe { return ZSTD_CCtx_setPledgedSrcSize(cctx, pledgedSrcSize) }
}

public const ZSTD_reset_session_only: ZSTD_ResetDirective = 1
public const ZSTD_reset_parameters: ZSTD_ResetDirective = 2
public const ZSTD_reset_session_and_parameters: ZSTD_ResetDirective = 3

public type ZSTD_ResetDirective = UInt32

// ZSTD_CCtx_reset() :
//  There are 2 different things that can be reset, independently or jointly :
//  - The session : will stop compressing current frame, and make CCtx ready to start a new one.
//                  Useful after an error, or to interrupt any ongoing compression.
//                  Any internal data not yet flushed is cancelled.
//                  Compression parameters and dictionary remain unchanged.
//                  They will be used to compress next frame.
//                  Resetting session never fails.
//  - The parameters : changes all parameters back to "default".
//                  This also removes any reference to any dictionary or external sequence producer.
//                  Parameters can only be changed between 2 sessions (i.e. no compression is currently ongoing)
//                  otherwise the reset fails, and function returns an error value (which can be tested using ZSTD_isError())
//  - Both : similar to resetting the session, followed by resetting parameters.
foreign func ZSTD_CCtx_reset(cctx: CPointer<ZSTD_CCtx>, reset: ZSTD_ResetDirective): UIntNative

// ZSTD_CCtx_reset() :
//  There are 2 different things that can be reset, independently or jointly :
//  - The session : will stop compressing current frame, and make CCtx ready to start a new one.
//                  Useful after an error, or to interrupt any ongoing compression.
//                  Any internal data not yet flushed is cancelled.
//                  Compression parameters and dictionary remain unchanged.
//                  They will be used to compress next frame.
//                  Resetting session never fails.
//  - The parameters : changes all parameters back to "default".
//                  This also removes any reference to any dictionary or external sequence producer.
//                  Parameters can only be changed between 2 sessions (i.e. no compression is currently ongoing)
//                  otherwise the reset fails, and function returns an error value (which can be tested using ZSTD_isError())
//  - Both : similar to resetting the session, followed by resetting parameters.
public func ZSTD_CCtx_reset_wrapper(cctx: CPointer<ZSTD_CCtx>, reset: ZSTD_ResetDirective): UIntNative {
    unsafe { return ZSTD_CCtx_reset(cctx, reset) }
}

// ZSTD_compress2() :
//  Behave the same as ZSTD_compressCCtx(), but compression parameters are set using the advanced API.
//  (note that this entry point doesn't even expose a compression level parameter).
//  ZSTD_compress2() always starts a new frame.
//  Should cctx hold data from a previously unfinished frame, everything about it is forgotten.
//  - Compression parameters are pushed into CCtx before starting compression, using ZSTD_CCtx_set*()
//  - The function is always blocking, returns when compression is completed.
//  NOTE: Providing `dstCapacity >= ZSTD_compressBound(srcSize)` guarantees that zstd will have
//        enough space to successfully compress the data, though it is possible it fails for other reasons.
// @return : compressed size written into `dst` (<= `dstCapacity),
//           or an error code if it fails (which can be tested using ZSTD_isError()).
foreign func ZSTD_compress2(cctx: CPointer<ZSTD_CCtx>, dst: CPointer<Unit>, dstCapacity: UIntNative,
    src: CPointer<Unit>, srcSize: UIntNative): UIntNative

// ZSTD_compress2() :
//  Behave the same as ZSTD_compressCCtx(), but compression parameters are set using the advanced API.
//  (note that this entry point doesn't even expose a compression level parameter).
//  ZSTD_compress2() always starts a new frame.
//  Should cctx hold data from a previously unfinished frame, everything about it is forgotten.
//  - Compression parameters are pushed into CCtx before starting compression, using ZSTD_CCtx_set*()
//  - The function is always blocking, returns when compression is completed.
//  NOTE: Providing `dstCapacity >= ZSTD_compressBound(srcSize)` guarantees that zstd will have
//        enough space to successfully compress the data, though it is possible it fails for other reasons.
// @return : compressed size written into `dst` (<= `dstCapacity),
//           or an error code if it fails (which can be tested using ZSTD_isError()).
public func ZSTD_compress2_wrapper(cctx: CPointer<ZSTD_CCtx>, dst: CPointer<Unit>, dstCapacity: UIntNative,
    src: CPointer<Unit>, srcSize: UIntNative): UIntNative {
    unsafe { return ZSTD_compress2(cctx, dst, dstCapacity, src, srcSize) }
}

public const ZSTD_d_windowLogMax: ZSTD_dParameter = 100
public const ZSTD_d_experimentalParam1: ZSTD_dParameter = 1000
public const ZSTD_d_experimentalParam2: ZSTD_dParameter = 1001
public const ZSTD_d_experimentalParam3: ZSTD_dParameter = 1002
public const ZSTD_d_experimentalParam4: ZSTD_dParameter = 1003
public const ZSTD_d_experimentalParam5: ZSTD_dParameter = 1004
public const ZSTD_d_experimentalParam6: ZSTD_dParameter = 1005

//  Advanced decompression API (Requires v1.4.0+)
public type ZSTD_dParameter = UInt32

// ZSTD_dParam_getBounds() :
//  All parameters must belong to an interval with lower and upper bounds,
//  otherwise they will either trigger an error or be automatically clamped.
// @return : a structure, ZSTD_bounds, which contains
//         - an error status field, which must be tested using ZSTD_isError()
//         - both lower and upper bounds, inclusive
foreign func ZSTD_dParam_getBounds(dParam: ZSTD_dParameter): ZSTD_bounds

// ZSTD_dParam_getBounds() :
//  All parameters must belong to an interval with lower and upper bounds,
//  otherwise they will either trigger an error or be automatically clamped.
// @return : a structure, ZSTD_bounds, which contains
//         - an error status field, which must be tested using ZSTD_isError()
//         - both lower and upper bounds, inclusive
public func ZSTD_dParam_getBounds_wrapper(dParam: ZSTD_dParameter): ZSTD_bounds {
    unsafe { return ZSTD_dParam_getBounds(dParam) }
}

// ZSTD_DCtx_setParameter() :
//  Set one compression parameter, selected by enum ZSTD_dParameter.
//  All parameters have valid bounds. Bounds can be queried using ZSTD_dParam_getBounds().
//  Providing a value beyond bound will either clamp it, or trigger an error (depending on parameter).
//  Setting a parameter is only possible during frame initialization (before starting decompression).
// @return : 0, or an error code (which can be tested using ZSTD_isError()).
foreign func ZSTD_DCtx_setParameter(dctx: CPointer<ZSTD_DCtx>, param: ZSTD_dParameter, value: Int32): UIntNative

// ZSTD_DCtx_setParameter() :
//  Set one compression parameter, selected by enum ZSTD_dParameter.
//  All parameters have valid bounds. Bounds can be queried using ZSTD_dParam_getBounds().
//  Providing a value beyond bound will either clamp it, or trigger an error (depending on parameter).
//  Setting a parameter is only possible during frame initialization (before starting decompression).
// @return : 0, or an error code (which can be tested using ZSTD_isError()).
public func ZSTD_DCtx_setParameter_wrapper(dctx: CPointer<ZSTD_DCtx>, param: ZSTD_dParameter, value: Int32): UIntNative {
    unsafe { return ZSTD_DCtx_setParameter(dctx, param, value) }
}

// ZSTD_DCtx_reset() :
//  Return a DCtx to clean state.
//  Session and parameters can be reset jointly or separately.
//  Parameters can only be reset when no active frame is being decompressed.
// @return : 0, or an error code, which can be tested with ZSTD_isError()
foreign func ZSTD_DCtx_reset(dctx: CPointer<ZSTD_DCtx>, reset: ZSTD_ResetDirective): UIntNative

// ZSTD_DCtx_reset() :
//  Return a DCtx to clean state.
//  Session and parameters can be reset jointly or separately.
//  Parameters can only be reset when no active frame is being decompressed.
// @return : 0, or an error code, which can be tested with ZSTD_isError()
public func ZSTD_DCtx_reset_wrapper(dctx: CPointer<ZSTD_DCtx>, reset: ZSTD_ResetDirective): UIntNative {
    unsafe { return ZSTD_DCtx_reset(dctx, reset) }
}

//  Streaming
@C
public struct ZSTD_inBuffer_s {
    //< start of input buffer
    public let src: CPointer<Unit>
    //< size of input buffer
    public let size: UIntNative
    //< position where reading stopped. Will be updated. Necessarily 0 <= pos <= size
    public let pos: UIntNative

    init(src: CPointer<Unit>, size: UIntNative, pos: UIntNative) {
        this.src = src
        this.size = size
        this.pos = pos
    }
}

//  Streaming
public type ZSTD_inBuffer = ZSTD_inBuffer_s

@C
public struct ZSTD_outBuffer_s {
    //< start of output buffer
    public let dst: CPointer<Unit>
    //< size of output buffer
    public let size: UIntNative
    //< position where writing stopped. Will be updated. Necessarily 0 <= pos <= size
    public let pos: UIntNative

    init(dst: CPointer<Unit>, size: UIntNative, pos: UIntNative) {
        this.dst = dst
        this.size = size
        this.pos = pos
    }
}

public type ZSTD_outBuffer = ZSTD_outBuffer_s

public type ZSTD_CStream = ZSTD_CCtx

foreign func ZSTD_createCStream(): CPointer<ZSTD_CStream>

public func ZSTD_createCStream_wrapper(): CPointer<ZSTD_CStream> {
    unsafe { return ZSTD_createCStream() }
}

foreign func ZSTD_freeCStream(zcs: CPointer<ZSTD_CStream>): UIntNative

public func ZSTD_freeCStream_wrapper(zcs: CPointer<ZSTD_CStream>): UIntNative {
    unsafe { return ZSTD_freeCStream(zcs) }
}

public const ZSTD_e_continue: ZSTD_EndDirective = 0
public const ZSTD_e_flush: ZSTD_EndDirective = 1
public const ZSTD_e_end: ZSTD_EndDirective = 2

public type ZSTD_EndDirective = UInt32

// ZSTD_compressStream2() : Requires v1.4.0+
//  Behaves about the same as ZSTD_compressStream, with additional control on end directive.
//  - Compression parameters are pushed into CCtx before starting compression, using ZSTD_CCtx_set*()
//  - Compression parameters cannot be changed once compression is started (save a list of exceptions in multi-threading mode)
//  - output->pos must be <= dstCapacity, input->pos must be <= srcSize
//  - output->pos and input->pos will be updated. They are guaranteed to remain below their respective limit.
//  - endOp must be a valid directive
//  - When nbWorkers==0 (default), function is blocking : it completes its job before returning to caller.
//  - When nbWorkers>=1, function is non-blocking : it copies a portion of input, distributes jobs to internal worker threads, flush to output whatever is available,
//                                                  and then immediately returns, just indicating that there is some data remaining to be flushed.
//                                                  The function nonetheless guarantees forward progress : it will return only after it reads or write at least 1+ byte.
//  - Exception : if the first call requests a ZSTD_e_end directive and provides enough dstCapacity, the function delegates to ZSTD_compress2() which is always blocking.
//  - @return provides a minimum amount of data remaining to be flushed from internal buffers
//            or an error code, which can be tested using ZSTD_isError().
//            if @return != 0, flush is not fully completed, there is still some data left within internal buffers.
//            This is useful for ZSTD_e_flush, since in this case more flushes are necessary to empty all buffers.
//            For ZSTD_e_end, @return == 0 when internal buffers are fully flushed and frame is completed.
//  - after a ZSTD_e_end directive, if internal buffer is not fully flushed (@return != 0),
//            only ZSTD_e_end or ZSTD_e_flush operations are allowed.
//            Before starting a new compression job, or changing compression parameters,
//            it is required to fully flush internal buffers.
//  - note: if an operation ends with an error, it may leave @cctx in an undefined state.
//          Therefore, it's UB to invoke ZSTD_compressStream2() of ZSTD_compressStream() on such a state.
//          In order to be re-employed after an error, a state must be reset,
//          which can be done explicitly (ZSTD_CCtx_reset()),
//          or is sometimes implied by methods starting a new compression job (ZSTD_initCStream(), ZSTD_compressCCtx())
foreign func ZSTD_compressStream2(cctx: CPointer<ZSTD_CCtx>, output: CPointer<ZSTD_outBuffer>,
    input: CPointer<ZSTD_inBuffer>, endOp: ZSTD_EndDirective): UIntNative

// ZSTD_compressStream2() : Requires v1.4.0+
//  Behaves about the same as ZSTD_compressStream, with additional control on end directive.
//  - Compression parameters are pushed into CCtx before starting compression, using ZSTD_CCtx_set*()
//  - Compression parameters cannot be changed once compression is started (save a list of exceptions in multi-threading mode)
//  - output->pos must be <= dstCapacity, input->pos must be <= srcSize
//  - output->pos and input->pos will be updated. They are guaranteed to remain below their respective limit.
//  - endOp must be a valid directive
//  - When nbWorkers==0 (default), function is blocking : it completes its job before returning to caller.
//  - When nbWorkers>=1, function is non-blocking : it copies a portion of input, distributes jobs to internal worker threads, flush to output whatever is available,
//                                                  and then immediately returns, just indicating that there is some data remaining to be flushed.
//                                                  The function nonetheless guarantees forward progress : it will return only after it reads or write at least 1+ byte.
//  - Exception : if the first call requests a ZSTD_e_end directive and provides enough dstCapacity, the function delegates to ZSTD_compress2() which is always blocking.
//  - @return provides a minimum amount of data remaining to be flushed from internal buffers
//            or an error code, which can be tested using ZSTD_isError().
//            if @return != 0, flush is not fully completed, there is still some data left within internal buffers.
//            This is useful for ZSTD_e_flush, since in this case more flushes are necessary to empty all buffers.
//            For ZSTD_e_end, @return == 0 when internal buffers are fully flushed and frame is completed.
//  - after a ZSTD_e_end directive, if internal buffer is not fully flushed (@return != 0),
//            only ZSTD_e_end or ZSTD_e_flush operations are allowed.
//            Before starting a new compression job, or changing compression parameters,
//            it is required to fully flush internal buffers.
//  - note: if an operation ends with an error, it may leave @cctx in an undefined state.
//          Therefore, it's UB to invoke ZSTD_compressStream2() of ZSTD_compressStream() on such a state.
//          In order to be re-employed after an error, a state must be reset,
//          which can be done explicitly (ZSTD_CCtx_reset()),
//          or is sometimes implied by methods starting a new compression job (ZSTD_initCStream(), ZSTD_compressCCtx())
public func ZSTD_compressStream2_wrapper(cctx: CPointer<ZSTD_CCtx>, output: CPointer<ZSTD_outBuffer>,
    input: CPointer<ZSTD_inBuffer>, endOp: ZSTD_EndDirective): UIntNative {
    unsafe { return ZSTD_compressStream2(cctx, output, input, endOp) }
}

foreign func ZSTD_CStreamInSize(): UIntNative

public func ZSTD_CStreamInSize_wrapper(): UIntNative {
    unsafe { return ZSTD_CStreamInSize() }
}

foreign func ZSTD_CStreamOutSize(): UIntNative

public func ZSTD_CStreamOutSize_wrapper(): UIntNative {
    unsafe { return ZSTD_CStreamOutSize() }
}

// Equivalent to:
//
//     ZSTD_CCtx_reset(zcs, ZSTD_reset_session_only);
//     ZSTD_CCtx_refCDict(zcs, NULL); // clear the dictionary (if any)
//     ZSTD_CCtx_setParameter(zcs, ZSTD_c_compressionLevel, compressionLevel);
//
// Note that ZSTD_initCStream() clears any previously set dictionary. Use the new API
// to compress with a dictionary.
foreign func ZSTD_initCStream(zcs: CPointer<ZSTD_CStream>, compressionLevel: Int32): UIntNative

// Equivalent to:
//
//     ZSTD_CCtx_reset(zcs, ZSTD_reset_session_only);
//     ZSTD_CCtx_refCDict(zcs, NULL); // clear the dictionary (if any)
//     ZSTD_CCtx_setParameter(zcs, ZSTD_c_compressionLevel, compressionLevel);
//
// Note that ZSTD_initCStream() clears any previously set dictionary. Use the new API
// to compress with a dictionary.
public func ZSTD_initCStream_wrapper(zcs: CPointer<ZSTD_CStream>, compressionLevel: Int32): UIntNative {
    unsafe { return ZSTD_initCStream(zcs, compressionLevel) }
}

// Alternative for ZSTD_compressStream2(zcs, output, input, ZSTD_e_continue).
// NOTE: The return value is different. ZSTD_compressStream() returns a hint for
// the next read size (if non-zero and not an error). ZSTD_compressStream2()
// returns the minimum nb of bytes left to flush (if non-zero and not an error).
foreign func ZSTD_compressStream(zcs: CPointer<ZSTD_CStream>, output: CPointer<ZSTD_outBuffer>,
    input: CPointer<ZSTD_inBuffer>): UIntNative

// Alternative for ZSTD_compressStream2(zcs, output, input, ZSTD_e_continue).
// NOTE: The return value is different. ZSTD_compressStream() returns a hint for
// the next read size (if non-zero and not an error). ZSTD_compressStream2()
// returns the minimum nb of bytes left to flush (if non-zero and not an error).
public func ZSTD_compressStream_wrapper(zcs: CPointer<ZSTD_CStream>, output: CPointer<ZSTD_outBuffer>,
    input: CPointer<ZSTD_inBuffer>): UIntNative {
    unsafe { return ZSTD_compressStream(zcs, output, input) }
}

// Equivalent to ZSTD_compressStream2(zcs, output, &emptyInput, ZSTD_e_flush).
foreign func ZSTD_flushStream(zcs: CPointer<ZSTD_CStream>, output: CPointer<ZSTD_outBuffer>): UIntNative

// Equivalent to ZSTD_compressStream2(zcs, output, &emptyInput, ZSTD_e_flush).
public func ZSTD_flushStream_wrapper(zcs: CPointer<ZSTD_CStream>, output: CPointer<ZSTD_outBuffer>): UIntNative {
    unsafe { return ZSTD_flushStream(zcs, output) }
}

// Equivalent to ZSTD_compressStream2(zcs, output, &emptyInput, ZSTD_e_end).
foreign func ZSTD_endStream(zcs: CPointer<ZSTD_CStream>, output: CPointer<ZSTD_outBuffer>): UIntNative

// Equivalent to ZSTD_compressStream2(zcs, output, &emptyInput, ZSTD_e_end).
public func ZSTD_endStream_wrapper(zcs: CPointer<ZSTD_CStream>, output: CPointer<ZSTD_outBuffer>): UIntNative {
    unsafe { return ZSTD_endStream(zcs, output) }
}

public type ZSTD_DStream = ZSTD_DCtx

foreign func ZSTD_createDStream(): CPointer<ZSTD_DStream>

public func ZSTD_createDStream_wrapper(): CPointer<ZSTD_DStream> {
    unsafe { return ZSTD_createDStream() }
}

foreign func ZSTD_freeDStream(zds: CPointer<ZSTD_DStream>): UIntNative

public func ZSTD_freeDStream_wrapper(zds: CPointer<ZSTD_DStream>): UIntNative {
    unsafe { return ZSTD_freeDStream(zds) }
}

// ZSTD_initDStream() :
// Initialize/reset DStream state for new decompression operation.
// Call before new decompression operation using same DStream.
//
// Note : This function is redundant with the advanced API and equivalent to:
//     ZSTD_DCtx_reset(zds, ZSTD_reset_session_only);
//     ZSTD_DCtx_refDDict(zds, NULL);
foreign func ZSTD_initDStream(zds: CPointer<ZSTD_DStream>): UIntNative

// ZSTD_initDStream() :
// Initialize/reset DStream state for new decompression operation.
// Call before new decompression operation using same DStream.
//
// Note : This function is redundant with the advanced API and equivalent to:
//     ZSTD_DCtx_reset(zds, ZSTD_reset_session_only);
//     ZSTD_DCtx_refDDict(zds, NULL);
public func ZSTD_initDStream_wrapper(zds: CPointer<ZSTD_DStream>): UIntNative {
    unsafe { return ZSTD_initDStream(zds) }
}

// ZSTD_decompressStream() :
// Streaming decompression function.
// Call repetitively to consume full input updating it as necessary.
// Function will update both input and output `pos` fields exposing current state via these fields:
// - `input.pos < input.size`, some input remaining and caller should provide remaining input
//   on the next call.
// - `output.pos < output.size`, decoder flushed internal output buffer.
// - `output.pos == output.size`, unflushed data potentially present in the internal buffers,
//   check ZSTD_decompressStream() @return value,
//   if > 0, invoke it again to flush remaining data to output.
// Note : with no additional input, amount of data flushed <= ZSTD_BLOCKSIZE_MAX.
//
// @return : 0 when a frame is completely decoded and fully flushed,
//           or an error code, which can be tested using ZSTD_isError(),
//           or any other value > 0, which means there is some decoding or flushing to do to complete current frame.
//
// Note: when an operation returns with an error code, the @zds state may be left in undefined state.
//       It's UB to invoke `ZSTD_decompressStream()` on such a state.
//       In order to re-use such a state, it must be first reset,
//       which can be done explicitly (`ZSTD_DCtx_reset()`),
//       or is implied for operations starting some new decompression job (`ZSTD_initDStream`, `ZSTD_decompressDCtx()`, `ZSTD_decompress_usingDict()`)
foreign func ZSTD_decompressStream(zds: CPointer<ZSTD_DStream>, output: CPointer<ZSTD_outBuffer>,
    input: CPointer<ZSTD_inBuffer>): UIntNative

// ZSTD_decompressStream() :
// Streaming decompression function.
// Call repetitively to consume full input updating it as necessary.
// Function will update both input and output `pos` fields exposing current state via these fields:
// - `input.pos < input.size`, some input remaining and caller should provide remaining input
//   on the next call.
// - `output.pos < output.size`, decoder flushed internal output buffer.
// - `output.pos == output.size`, unflushed data potentially present in the internal buffers,
//   check ZSTD_decompressStream() @return value,
//   if > 0, invoke it again to flush remaining data to output.
// Note : with no additional input, amount of data flushed <= ZSTD_BLOCKSIZE_MAX.
//
// @return : 0 when a frame is completely decoded and fully flushed,
//           or an error code, which can be tested using ZSTD_isError(),
//           or any other value > 0, which means there is some decoding or flushing to do to complete current frame.
//
// Note: when an operation returns with an error code, the @zds state may be left in undefined state.
//       It's UB to invoke `ZSTD_decompressStream()` on such a state.
//       In order to re-use such a state, it must be first reset,
//       which can be done explicitly (`ZSTD_DCtx_reset()`),
//       or is implied for operations starting some new decompression job (`ZSTD_initDStream`, `ZSTD_decompressDCtx()`, `ZSTD_decompress_usingDict()`)
public func ZSTD_decompressStream_wrapper(zds: CPointer<ZSTD_DStream>, output: CPointer<ZSTD_outBuffer>,
    input: CPointer<ZSTD_inBuffer>): UIntNative {
    unsafe { return ZSTD_decompressStream(zds, output, input) }
}

foreign func ZSTD_DStreamInSize(): UIntNative

public func ZSTD_DStreamInSize_wrapper(): UIntNative {
    unsafe { return ZSTD_DStreamInSize() }
}

foreign func ZSTD_DStreamOutSize(): UIntNative

public func ZSTD_DStreamOutSize_wrapper(): UIntNative {
    unsafe { return ZSTD_DStreamOutSize() }
}

//  Simple dictionary API
///
///*! ZSTD_compress_usingDict() :
//  Compression at an explicit compression level using a Dictionary.
//  A dictionary can be any arbitrary data segment (also called a prefix),
//  or a buffer with specified information (see zdict.h).
//  Note : This function loads the dictionary, resulting in significant startup delay.
//         It's intended for a dictionary used only once.
//  Note 2 : When `dict == NULL || dictSize < 8` no dictionary is used.
foreign func ZSTD_compress_usingDict(ctx: CPointer<ZSTD_CCtx>, dst: CPointer<Unit>, dstCapacity: UIntNative,
    src: CPointer<Unit>, srcSize: UIntNative, dict: CPointer<Unit>, dictSize: UIntNative, compressionLevel: Int32): UIntNative

//  Simple dictionary API
///
///*! ZSTD_compress_usingDict() :
//  Compression at an explicit compression level using a Dictionary.
//  A dictionary can be any arbitrary data segment (also called a prefix),
//  or a buffer with specified information (see zdict.h).
//  Note : This function loads the dictionary, resulting in significant startup delay.
//         It's intended for a dictionary used only once.
//  Note 2 : When `dict == NULL || dictSize < 8` no dictionary is used.
public func ZSTD_compress_usingDict_wrapper(ctx: CPointer<ZSTD_CCtx>, dst: CPointer<Unit>, dstCapacity: UIntNative,
    src: CPointer<Unit>, srcSize: UIntNative, dict: CPointer<Unit>, dictSize: UIntNative, compressionLevel: Int32): UIntNative {
    unsafe { return ZSTD_compress_usingDict(ctx, dst, dstCapacity, src, srcSize, dict, dictSize, compressionLevel) }
}

// ZSTD_decompress_usingDict() :
//  Decompression using a known Dictionary.
//  Dictionary must be identical to the one used during compression.
//  Note : This function loads the dictionary, resulting in significant startup delay.
//         It's intended for a dictionary used only once.
//  Note : When `dict == NULL || dictSize < 8` no dictionary is used.
foreign func ZSTD_decompress_usingDict(dctx: CPointer<ZSTD_DCtx>, dst: CPointer<Unit>, dstCapacity: UIntNative,
    src: CPointer<Unit>, srcSize: UIntNative, dict: CPointer<Unit>, dictSize: UIntNative): UIntNative

// ZSTD_decompress_usingDict() :
//  Decompression using a known Dictionary.
//  Dictionary must be identical to the one used during compression.
//  Note : This function loads the dictionary, resulting in significant startup delay.
//         It's intended for a dictionary used only once.
//  Note : When `dict == NULL || dictSize < 8` no dictionary is used.
public func ZSTD_decompress_usingDict_wrapper(dctx: CPointer<ZSTD_DCtx>, dst: CPointer<Unit>, dstCapacity: UIntNative,
    src: CPointer<Unit>, srcSize: UIntNative, dict: CPointer<Unit>, dictSize: UIntNative): UIntNative {
    unsafe { return ZSTD_decompress_usingDict(dctx, dst, dstCapacity, src, srcSize, dict, dictSize) }
}

@C
public struct ZSTD_CDict_s {
    init() {
        throw Exception("opaque type should not be inited")
    }
}

//  Bulk processing dictionary API
public type ZSTD_CDict = ZSTD_CDict_s

// ZSTD_createCDict() :
//  When compressing multiple messages or blocks using the same dictionary,
//  it's recommended to digest the dictionary only once, since it's a costly operation.
//  ZSTD_createCDict() will create a state from digesting a dictionary.
//  The resulting state can be used for future compression operations with very limited startup cost.
//  ZSTD_CDict can be created once and shared by multiple threads concurrently, since its usage is read-only.
// @dictBuffer can be released after ZSTD_CDict creation, because its content is copied within CDict.
//  Note 1 : Consider experimental function `ZSTD_createCDict_byReference()` if you prefer to not duplicate @dictBuffer content.
//  Note 2 : A ZSTD_CDict can be created from an empty @dictBuffer,
//      in which case the only thing that it transports is the @compressionLevel.
//      This can be useful in a pipeline featuring ZSTD_compress_usingCDict() exclusively,
//      expecting a ZSTD_CDict parameter with any data, including those without a known dictionary.
foreign func ZSTD_createCDict(dictBuffer: CPointer<Unit>, dictSize: UIntNative, compressionLevel: Int32): CPointer<ZSTD_CDict>

// ZSTD_createCDict() :
//  When compressing multiple messages or blocks using the same dictionary,
//  it's recommended to digest the dictionary only once, since it's a costly operation.
//  ZSTD_createCDict() will create a state from digesting a dictionary.
//  The resulting state can be used for future compression operations with very limited startup cost.
//  ZSTD_CDict can be created once and shared by multiple threads concurrently, since its usage is read-only.
// @dictBuffer can be released after ZSTD_CDict creation, because its content is copied within CDict.
//  Note 1 : Consider experimental function `ZSTD_createCDict_byReference()` if you prefer to not duplicate @dictBuffer content.
//  Note 2 : A ZSTD_CDict can be created from an empty @dictBuffer,
//      in which case the only thing that it transports is the @compressionLevel.
//      This can be useful in a pipeline featuring ZSTD_compress_usingCDict() exclusively,
//      expecting a ZSTD_CDict parameter with any data, including those without a known dictionary.
public func ZSTD_createCDict_wrapper(dictBuffer: CPointer<Unit>, dictSize: UIntNative, compressionLevel: Int32): CPointer<ZSTD_CDict> {
    unsafe { return ZSTD_createCDict(dictBuffer, dictSize, compressionLevel) }
}

// ZSTD_freeCDict() :
//  Function frees memory allocated by ZSTD_createCDict().
//  If a NULL pointer is passed, no operation is performed.
foreign func ZSTD_freeCDict(CDict: CPointer<ZSTD_CDict>): UIntNative

// ZSTD_freeCDict() :
//  Function frees memory allocated by ZSTD_createCDict().
//  If a NULL pointer is passed, no operation is performed.
public func ZSTD_freeCDict_wrapper(CDict: CPointer<ZSTD_CDict>): UIntNative {
    unsafe { return ZSTD_freeCDict(CDict) }
}

// ZSTD_compress_usingCDict() :
//  Compression using a digested Dictionary.
//  Recommended when same dictionary is used multiple times.
//  Note : compression level is _decided at dictionary creation time_,
//     and frame parameters are hardcoded (dictID=yes, contentSize=yes, checksum=no)
foreign func ZSTD_compress_usingCDict(cctx: CPointer<ZSTD_CCtx>, dst: CPointer<Unit>, dstCapacity: UIntNative,
    src: CPointer<Unit>, srcSize: UIntNative, cdict: CPointer<ZSTD_CDict>): UIntNative

// ZSTD_compress_usingCDict() :
//  Compression using a digested Dictionary.
//  Recommended when same dictionary is used multiple times.
//  Note : compression level is _decided at dictionary creation time_,
//     and frame parameters are hardcoded (dictID=yes, contentSize=yes, checksum=no)
public func ZSTD_compress_usingCDict_wrapper(cctx: CPointer<ZSTD_CCtx>, dst: CPointer<Unit>, dstCapacity: UIntNative,
    src: CPointer<Unit>, srcSize: UIntNative, cdict: CPointer<ZSTD_CDict>): UIntNative {
    unsafe { return ZSTD_compress_usingCDict(cctx, dst, dstCapacity, src, srcSize, cdict) }
}

@C
public struct ZSTD_DDict_s {
    init() {
        throw Exception("opaque type should not be inited")
    }
}

public type ZSTD_DDict = ZSTD_DDict_s

// ZSTD_createDDict() :
//  Create a digested dictionary, ready to start decompression operation without startup delay.
//  dictBuffer can be released after DDict creation, as its content is copied inside DDict.
foreign func ZSTD_createDDict(dictBuffer: CPointer<Unit>, dictSize: UIntNative): CPointer<ZSTD_DDict>

// ZSTD_createDDict() :
//  Create a digested dictionary, ready to start decompression operation without startup delay.
//  dictBuffer can be released after DDict creation, as its content is copied inside DDict.
public func ZSTD_createDDict_wrapper(dictBuffer: CPointer<Unit>, dictSize: UIntNative): CPointer<ZSTD_DDict> {
    unsafe { return ZSTD_createDDict(dictBuffer, dictSize) }
}

// ZSTD_freeDDict() :
//  Function frees memory allocated with ZSTD_createDDict()
//  If a NULL pointer is passed, no operation is performed.
foreign func ZSTD_freeDDict(ddict: CPointer<ZSTD_DDict>): UIntNative

// ZSTD_freeDDict() :
//  Function frees memory allocated with ZSTD_createDDict()
//  If a NULL pointer is passed, no operation is performed.
public func ZSTD_freeDDict_wrapper(ddict: CPointer<ZSTD_DDict>): UIntNative {
    unsafe { return ZSTD_freeDDict(ddict) }
}

// ZSTD_decompress_usingDDict() :
//  Decompression using a digested Dictionary.
//  Recommended when same dictionary is used multiple times.
foreign func ZSTD_decompress_usingDDict(dctx: CPointer<ZSTD_DCtx>, dst: CPointer<Unit>, dstCapacity: UIntNative,
    src: CPointer<Unit>, srcSize: UIntNative, ddict: CPointer<ZSTD_DDict>): UIntNative

// ZSTD_decompress_usingDDict() :
//  Decompression using a digested Dictionary.
//  Recommended when same dictionary is used multiple times.
public func ZSTD_decompress_usingDDict_wrapper(dctx: CPointer<ZSTD_DCtx>, dst: CPointer<Unit>, dstCapacity: UIntNative,
    src: CPointer<Unit>, srcSize: UIntNative, ddict: CPointer<ZSTD_DDict>): UIntNative {
    unsafe { return ZSTD_decompress_usingDDict(dctx, dst, dstCapacity, src, srcSize, ddict) }
}

// ZSTD_getDictID_fromDict() : Requires v1.4.0+
//  Provides the dictID stored within dictionary.
//  if @return == 0, the dictionary is not conformant with Zstandard specification.
//  It can still be loaded, but as a content-only dictionary.
foreign func ZSTD_getDictID_fromDict(dict: CPointer<Unit>, dictSize: UIntNative): UInt32

// ZSTD_getDictID_fromDict() : Requires v1.4.0+
//  Provides the dictID stored within dictionary.
//  if @return == 0, the dictionary is not conformant with Zstandard specification.
//  It can still be loaded, but as a content-only dictionary.
public func ZSTD_getDictID_fromDict_wrapper(dict: CPointer<Unit>, dictSize: UIntNative): UInt32 {
    unsafe { return ZSTD_getDictID_fromDict(dict, dictSize) }
}

// ZSTD_getDictID_fromCDict() : Requires v1.5.0+
//  Provides the dictID of the dictionary loaded into `cdict`.
//  If @return == 0, the dictionary is not conformant to Zstandard specification, or empty.
//  Non-conformant dictionaries can still be loaded, but as content-only dictionaries.
foreign func ZSTD_getDictID_fromCDict(cdict: CPointer<ZSTD_CDict>): UInt32

// ZSTD_getDictID_fromCDict() : Requires v1.5.0+
//  Provides the dictID of the dictionary loaded into `cdict`.
//  If @return == 0, the dictionary is not conformant to Zstandard specification, or empty.
//  Non-conformant dictionaries can still be loaded, but as content-only dictionaries.
public func ZSTD_getDictID_fromCDict_wrapper(cdict: CPointer<ZSTD_CDict>): UInt32 {
    unsafe { return ZSTD_getDictID_fromCDict(cdict) }
}

// ZSTD_getDictID_fromDDict() : Requires v1.4.0+
//  Provides the dictID of the dictionary loaded into `ddict`.
//  If @return == 0, the dictionary is not conformant to Zstandard specification, or empty.
//  Non-conformant dictionaries can still be loaded, but as content-only dictionaries.
foreign func ZSTD_getDictID_fromDDict(ddict: CPointer<ZSTD_DDict>): UInt32

// ZSTD_getDictID_fromDDict() : Requires v1.4.0+
//  Provides the dictID of the dictionary loaded into `ddict`.
//  If @return == 0, the dictionary is not conformant to Zstandard specification, or empty.
//  Non-conformant dictionaries can still be loaded, but as content-only dictionaries.
public func ZSTD_getDictID_fromDDict_wrapper(ddict: CPointer<ZSTD_DDict>): UInt32 {
    unsafe { return ZSTD_getDictID_fromDDict(ddict) }
}

// ZSTD_getDictID_fromFrame() : Requires v1.4.0+
//  Provides the dictID required to decompressed the frame stored within `src`.
//  If @return == 0, the dictID could not be decoded.
//  This could for one of the following reasons :
//  - The frame does not require a dictionary to be decoded (most common case).
//  - The frame was built with dictID intentionally removed. Whatever dictionary is necessary is a hidden piece of information.
//    Note : this use case also happens when using a non-conformant dictionary.
//  - `srcSize` is too small, and as a result, the frame header could not be decoded (only possible if `srcSize < ZSTD_FRAMEHEADERSIZE_MAX`).
//  - This is not a Zstandard frame.
//  When identifying the exact failure cause, it's possible to use ZSTD_getFrameHeader(), which will provide a more precise error code.
foreign func ZSTD_getDictID_fromFrame(src: CPointer<Unit>, srcSize: UIntNative): UInt32

// ZSTD_getDictID_fromFrame() : Requires v1.4.0+
//  Provides the dictID required to decompressed the frame stored within `src`.
//  If @return == 0, the dictID could not be decoded.
//  This could for one of the following reasons :
//  - The frame does not require a dictionary to be decoded (most common case).
//  - The frame was built with dictID intentionally removed. Whatever dictionary is necessary is a hidden piece of information.
//    Note : this use case also happens when using a non-conformant dictionary.
//  - `srcSize` is too small, and as a result, the frame header could not be decoded (only possible if `srcSize < ZSTD_FRAMEHEADERSIZE_MAX`).
//  - This is not a Zstandard frame.
//  When identifying the exact failure cause, it's possible to use ZSTD_getFrameHeader(), which will provide a more precise error code.
public func ZSTD_getDictID_fromFrame_wrapper(src: CPointer<Unit>, srcSize: UIntNative): UInt32 {
    unsafe { return ZSTD_getDictID_fromFrame(src, srcSize) }
}

// ZSTD_CCtx_loadDictionary() : Requires v1.4.0+
//  Create an internal CDict from `dict` buffer.
//  Decompression will have to use same dictionary.
// @result : 0, or an error code (which can be tested with ZSTD_isError()).
//  Special: Loading a NULL (or 0-size) dictionary invalidates previous dictionary,
//           meaning "return to no-dictionary mode".
//  Note 1 : Dictionary is sticky, it will be used for all future compressed frames,
//           until parameters are reset, a new dictionary is loaded, or the dictionary
//           is explicitly invalidated by loading a NULL dictionary.
//  Note 2 : Loading a dictionary involves building tables.
//           It's also a CPU consuming operation, with non-negligible impact on latency.
//           Tables are dependent on compression parameters, and for this reason,
//           compression parameters can no longer be changed after loading a dictionary.
//  Note 3 :`dict` content will be copied internally.
//           Use experimental ZSTD_CCtx_loadDictionary_byReference() to reference content instead.
//           In such a case, dictionary buffer must outlive its users.
//  Note 4 : Use ZSTD_CCtx_loadDictionary_advanced()
//           to precisely select how dictionary content must be interpreted.
//  Note 5 : This method does not benefit from LDM (long distance mode).
//           If you want to employ LDM on some large dictionary content,
//           prefer employing ZSTD_CCtx_refPrefix() described below.
foreign func ZSTD_CCtx_loadDictionary(cctx: CPointer<ZSTD_CCtx>, dict: CPointer<Unit>, dictSize: UIntNative): UIntNative

// ZSTD_CCtx_loadDictionary() : Requires v1.4.0+
//  Create an internal CDict from `dict` buffer.
//  Decompression will have to use same dictionary.
// @result : 0, or an error code (which can be tested with ZSTD_isError()).
//  Special: Loading a NULL (or 0-size) dictionary invalidates previous dictionary,
//           meaning "return to no-dictionary mode".
//  Note 1 : Dictionary is sticky, it will be used for all future compressed frames,
//           until parameters are reset, a new dictionary is loaded, or the dictionary
//           is explicitly invalidated by loading a NULL dictionary.
//  Note 2 : Loading a dictionary involves building tables.
//           It's also a CPU consuming operation, with non-negligible impact on latency.
//           Tables are dependent on compression parameters, and for this reason,
//           compression parameters can no longer be changed after loading a dictionary.
//  Note 3 :`dict` content will be copied internally.
//           Use experimental ZSTD_CCtx_loadDictionary_byReference() to reference content instead.
//           In such a case, dictionary buffer must outlive its users.
//  Note 4 : Use ZSTD_CCtx_loadDictionary_advanced()
//           to precisely select how dictionary content must be interpreted.
//  Note 5 : This method does not benefit from LDM (long distance mode).
//           If you want to employ LDM on some large dictionary content,
//           prefer employing ZSTD_CCtx_refPrefix() described below.
public func ZSTD_CCtx_loadDictionary_wrapper(cctx: CPointer<ZSTD_CCtx>, dict: CPointer<Unit>, dictSize: UIntNative): UIntNative {
    unsafe { return ZSTD_CCtx_loadDictionary(cctx, dict, dictSize) }
}

// ZSTD_CCtx_refCDict() : Requires v1.4.0+
//  Reference a prepared dictionary, to be used for all future compressed frames.
//  Note that compression parameters are enforced from within CDict,
//  and supersede any compression parameter previously set within CCtx.
//  The parameters ignored are labelled as "superseded-by-cdict" in the ZSTD_cParameter enum docs.
//  The ignored parameters will be used again if the CCtx is returned to no-dictionary mode.
//  The dictionary will remain valid for future compressed frames using same CCtx.
// @result : 0, or an error code (which can be tested with ZSTD_isError()).
//  Special : Referencing a NULL CDict means "return to no-dictionary mode".
//  Note 1 : Currently, only one dictionary can be managed.
//           Referencing a new dictionary effectively "discards" any previous one.
//  Note 2 : CDict is just referenced, its lifetime must outlive its usage within CCtx.
foreign func ZSTD_CCtx_refCDict(cctx: CPointer<ZSTD_CCtx>, cdict: CPointer<ZSTD_CDict>): UIntNative

// ZSTD_CCtx_refCDict() : Requires v1.4.0+
//  Reference a prepared dictionary, to be used for all future compressed frames.
//  Note that compression parameters are enforced from within CDict,
//  and supersede any compression parameter previously set within CCtx.
//  The parameters ignored are labelled as "superseded-by-cdict" in the ZSTD_cParameter enum docs.
//  The ignored parameters will be used again if the CCtx is returned to no-dictionary mode.
//  The dictionary will remain valid for future compressed frames using same CCtx.
// @result : 0, or an error code (which can be tested with ZSTD_isError()).
//  Special : Referencing a NULL CDict means "return to no-dictionary mode".
//  Note 1 : Currently, only one dictionary can be managed.
//           Referencing a new dictionary effectively "discards" any previous one.
//  Note 2 : CDict is just referenced, its lifetime must outlive its usage within CCtx.
public func ZSTD_CCtx_refCDict_wrapper(cctx: CPointer<ZSTD_CCtx>, cdict: CPointer<ZSTD_CDict>): UIntNative {
    unsafe { return ZSTD_CCtx_refCDict(cctx, cdict) }
}

// ZSTD_CCtx_refPrefix() : Requires v1.4.0+
//  Reference a prefix (single-usage dictionary) for next compressed frame.
//  A prefix is **only used once**. Tables are discarded at end of frame (ZSTD_e_end).
//  Decompression will need same prefix to properly regenerate data.
//  Compressing with a prefix is similar in outcome as performing a diff and compressing it,
//  but performs much faster, especially during decompression (compression speed is tunable with compression level).
//  This method is compatible with LDM (long distance mode).
// @result : 0, or an error code (which can be tested with ZSTD_isError()).
//  Special: Adding any prefix (including NULL) invalidates any previous prefix or dictionary
//  Note 1 : Prefix buffer is referenced. It **must** outlive compression.
//           Its content must remain unmodified during compression.
//  Note 2 : If the intention is to diff some large src data blob with some prior version of itself,
//           ensure that the window size is large enough to contain the entire source.
//           See ZSTD_c_windowLog.
//  Note 3 : Referencing a prefix involves building tables, which are dependent on compression parameters.
//           It's a CPU consuming operation, with non-negligible impact on latency.
//           If there is a need to use the same prefix multiple times, consider loadDictionary instead.
//  Note 4 : By default, the prefix is interpreted as raw content (ZSTD_dct_rawContent).
//           Use experimental ZSTD_CCtx_refPrefix_advanced() to alter dictionary interpretation.
foreign func ZSTD_CCtx_refPrefix(cctx: CPointer<ZSTD_CCtx>, prefix: CPointer<Unit>, prefixSize: UIntNative): UIntNative

// ZSTD_CCtx_refPrefix() : Requires v1.4.0+
//  Reference a prefix (single-usage dictionary) for next compressed frame.
//  A prefix is **only used once**. Tables are discarded at end of frame (ZSTD_e_end).
//  Decompression will need same prefix to properly regenerate data.
//  Compressing with a prefix is similar in outcome as performing a diff and compressing it,
//  but performs much faster, especially during decompression (compression speed is tunable with compression level).
//  This method is compatible with LDM (long distance mode).
// @result : 0, or an error code (which can be tested with ZSTD_isError()).
//  Special: Adding any prefix (including NULL) invalidates any previous prefix or dictionary
//  Note 1 : Prefix buffer is referenced. It **must** outlive compression.
//           Its content must remain unmodified during compression.
//  Note 2 : If the intention is to diff some large src data blob with some prior version of itself,
//           ensure that the window size is large enough to contain the entire source.
//           See ZSTD_c_windowLog.
//  Note 3 : Referencing a prefix involves building tables, which are dependent on compression parameters.
//           It's a CPU consuming operation, with non-negligible impact on latency.
//           If there is a need to use the same prefix multiple times, consider loadDictionary instead.
//  Note 4 : By default, the prefix is interpreted as raw content (ZSTD_dct_rawContent).
//           Use experimental ZSTD_CCtx_refPrefix_advanced() to alter dictionary interpretation.
public func ZSTD_CCtx_refPrefix_wrapper(cctx: CPointer<ZSTD_CCtx>, prefix: CPointer<Unit>, prefixSize: UIntNative): UIntNative {
    unsafe { return ZSTD_CCtx_refPrefix(cctx, prefix, prefixSize) }
}

// ZSTD_DCtx_loadDictionary() : Requires v1.4.0+
//  Create an internal DDict from dict buffer, to be used to decompress all future frames.
//  The dictionary remains valid for all future frames, until explicitly invalidated, or
//  a new dictionary is loaded.
// @result : 0, or an error code (which can be tested with ZSTD_isError()).
//  Special : Adding a NULL (or 0-size) dictionary invalidates any previous dictionary,
//            meaning "return to no-dictionary mode".
//  Note 1 : Loading a dictionary involves building tables,
//           which has a non-negligible impact on CPU usage and latency.
//           It's recommended to "load once, use many times", to amortize the cost
//  Note 2 :`dict` content will be copied internally, so `dict` can be released after loading.
//           Use ZSTD_DCtx_loadDictionary_byReference() to reference dictionary content instead.
//  Note 3 : Use ZSTD_DCtx_loadDictionary_advanced() to take control of
//           how dictionary content is loaded and interpreted.
foreign func ZSTD_DCtx_loadDictionary(dctx: CPointer<ZSTD_DCtx>, dict: CPointer<Unit>, dictSize: UIntNative): UIntNative

// ZSTD_DCtx_loadDictionary() : Requires v1.4.0+
//  Create an internal DDict from dict buffer, to be used to decompress all future frames.
//  The dictionary remains valid for all future frames, until explicitly invalidated, or
//  a new dictionary is loaded.
// @result : 0, or an error code (which can be tested with ZSTD_isError()).
//  Special : Adding a NULL (or 0-size) dictionary invalidates any previous dictionary,
//            meaning "return to no-dictionary mode".
//  Note 1 : Loading a dictionary involves building tables,
//           which has a non-negligible impact on CPU usage and latency.
//           It's recommended to "load once, use many times", to amortize the cost
//  Note 2 :`dict` content will be copied internally, so `dict` can be released after loading.
//           Use ZSTD_DCtx_loadDictionary_byReference() to reference dictionary content instead.
//  Note 3 : Use ZSTD_DCtx_loadDictionary_advanced() to take control of
//           how dictionary content is loaded and interpreted.
public func ZSTD_DCtx_loadDictionary_wrapper(dctx: CPointer<ZSTD_DCtx>, dict: CPointer<Unit>, dictSize: UIntNative): UIntNative {
    unsafe { return ZSTD_DCtx_loadDictionary(dctx, dict, dictSize) }
}

// ZSTD_DCtx_refDDict() : Requires v1.4.0+
//  Reference a prepared dictionary, to be used to decompress next frames.
//  The dictionary remains active for decompression of future frames using same DCtx.
//
//  If called with ZSTD_d_refMultipleDDicts enabled, repeated calls of this function
//  will store the DDict references in a table, and the DDict used for decompression
//  will be determined at decompression time, as per the dict ID in the frame.
//  The memory for the table is allocated on the first call to refDDict, and can be
//  freed with ZSTD_freeDCtx().
//
//  If called with ZSTD_d_refMultipleDDicts disabled (the default), only one dictionary
//  will be managed, and referencing a dictionary effectively "discards" any previous one.
//
// @result : 0, or an error code (which can be tested with ZSTD_isError()).
//  Special: referencing a NULL DDict means "return to no-dictionary mode".
//  Note 2 : DDict is just referenced, its lifetime must outlive its usage from DCtx.
foreign func ZSTD_DCtx_refDDict(dctx: CPointer<ZSTD_DCtx>, ddict: CPointer<ZSTD_DDict>): UIntNative

// ZSTD_DCtx_refDDict() : Requires v1.4.0+
//  Reference a prepared dictionary, to be used to decompress next frames.
//  The dictionary remains active for decompression of future frames using same DCtx.
//
//  If called with ZSTD_d_refMultipleDDicts enabled, repeated calls of this function
//  will store the DDict references in a table, and the DDict used for decompression
//  will be determined at decompression time, as per the dict ID in the frame.
//  The memory for the table is allocated on the first call to refDDict, and can be
//  freed with ZSTD_freeDCtx().
//
//  If called with ZSTD_d_refMultipleDDicts disabled (the default), only one dictionary
//  will be managed, and referencing a dictionary effectively "discards" any previous one.
//
// @result : 0, or an error code (which can be tested with ZSTD_isError()).
//  Special: referencing a NULL DDict means "return to no-dictionary mode".
//  Note 2 : DDict is just referenced, its lifetime must outlive its usage from DCtx.
public func ZSTD_DCtx_refDDict_wrapper(dctx: CPointer<ZSTD_DCtx>, ddict: CPointer<ZSTD_DDict>): UIntNative {
    unsafe { return ZSTD_DCtx_refDDict(dctx, ddict) }
}

// ZSTD_DCtx_refPrefix() : Requires v1.4.0+
//  Reference a prefix (single-usage dictionary) to decompress next frame.
//  This is the reverse operation of ZSTD_CCtx_refPrefix(),
//  and must use the same prefix as the one used during compression.
//  Prefix is **only used once**. Reference is discarded at end of frame.
//  End of frame is reached when ZSTD_decompressStream() returns 0.
// @result : 0, or an error code (which can be tested with ZSTD_isError()).
//  Note 1 : Adding any prefix (including NULL) invalidates any previously set prefix or dictionary
//  Note 2 : Prefix buffer is referenced. It **must** outlive decompression.
//           Prefix buffer must remain unmodified up to the end of frame,
//           reached when ZSTD_decompressStream() returns 0.
//  Note 3 : By default, the prefix is treated as raw content (ZSTD_dct_rawContent).
//           Use ZSTD_CCtx_refPrefix_advanced() to alter dictMode (Experimental section)
//  Note 4 : Referencing a raw content prefix has almost no cpu nor memory cost.
//           A full dictionary is more costly, as it requires building tables.
foreign func ZSTD_DCtx_refPrefix(dctx: CPointer<ZSTD_DCtx>, prefix: CPointer<Unit>, prefixSize: UIntNative): UIntNative

// ZSTD_DCtx_refPrefix() : Requires v1.4.0+
//  Reference a prefix (single-usage dictionary) to decompress next frame.
//  This is the reverse operation of ZSTD_CCtx_refPrefix(),
//  and must use the same prefix as the one used during compression.
//  Prefix is **only used once**. Reference is discarded at end of frame.
//  End of frame is reached when ZSTD_decompressStream() returns 0.
// @result : 0, or an error code (which can be tested with ZSTD_isError()).
//  Note 1 : Adding any prefix (including NULL) invalidates any previously set prefix or dictionary
//  Note 2 : Prefix buffer is referenced. It **must** outlive decompression.
//           Prefix buffer must remain unmodified up to the end of frame,
//           reached when ZSTD_decompressStream() returns 0.
//  Note 3 : By default, the prefix is treated as raw content (ZSTD_dct_rawContent).
//           Use ZSTD_CCtx_refPrefix_advanced() to alter dictMode (Experimental section)
//  Note 4 : Referencing a raw content prefix has almost no cpu nor memory cost.
//           A full dictionary is more costly, as it requires building tables.
public func ZSTD_DCtx_refPrefix_wrapper(dctx: CPointer<ZSTD_DCtx>, prefix: CPointer<Unit>, prefixSize: UIntNative): UIntNative {
    unsafe { return ZSTD_DCtx_refPrefix(dctx, prefix, prefixSize) }
}

// ZSTD_sizeof_*() : Requires v1.4.0+
//  These functions give the _current_ memory usage of selected object.
//  Note that object memory usage can evolve (increase or decrease) over time.
foreign func ZSTD_sizeof_CCtx(cctx: CPointer<ZSTD_CCtx>): UIntNative

// ZSTD_sizeof_*() : Requires v1.4.0+
//  These functions give the _current_ memory usage of selected object.
//  Note that object memory usage can evolve (increase or decrease) over time.
public func ZSTD_sizeof_CCtx_wrapper(cctx: CPointer<ZSTD_CCtx>): UIntNative {
    unsafe { return ZSTD_sizeof_CCtx(cctx) }
}

foreign func ZSTD_sizeof_DCtx(dctx: CPointer<ZSTD_DCtx>): UIntNative

public func ZSTD_sizeof_DCtx_wrapper(dctx: CPointer<ZSTD_DCtx>): UIntNative {
    unsafe { return ZSTD_sizeof_DCtx(dctx) }
}

foreign func ZSTD_sizeof_CStream(zcs: CPointer<ZSTD_CStream>): UIntNative

public func ZSTD_sizeof_CStream_wrapper(zcs: CPointer<ZSTD_CStream>): UIntNative {
    unsafe { return ZSTD_sizeof_CStream(zcs) }
}

foreign func ZSTD_sizeof_DStream(zds: CPointer<ZSTD_DStream>): UIntNative

public func ZSTD_sizeof_DStream_wrapper(zds: CPointer<ZSTD_DStream>): UIntNative {
    unsafe { return ZSTD_sizeof_DStream(zds) }
}

foreign func ZSTD_sizeof_CDict(cdict: CPointer<ZSTD_CDict>): UIntNative

public func ZSTD_sizeof_CDict_wrapper(cdict: CPointer<ZSTD_CDict>): UIntNative {
    unsafe { return ZSTD_sizeof_CDict(cdict) }
}

foreign func ZSTD_sizeof_DDict(ddict: CPointer<ZSTD_DDict>): UIntNative

public func ZSTD_sizeof_DDict_wrapper(ddict: CPointer<ZSTD_DDict>): UIntNative {
    unsafe { return ZSTD_sizeof_DDict(ddict) }
}
