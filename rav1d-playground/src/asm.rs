use std::ffi::c_int;

extern "C" {
    // src/pal.rs
    fn pal_idx_finish(dst: *mut u8, src: *const u8, bw: c_int, bh: c_int, w: c_int, h: c_int)
        -> ();

    // src/cdef.rs
    fn cdef(
        dst_ptr: *mut DynPixel,
        stride: ptrdiff_t,
        left: *const [LeftPixelRow2px<DynPixel>; 8],
        top_ptr: *const DynPixel,
        bottom_ptr: *const DynPixel,
        pri_strength: c_int,
        sec_strength: c_int,
        dir: c_int,
        damping: c_int,
        edges: CdefEdgeFlags,
        bitdepth_max: c_int,
        _dst: *const FFISafe<Rav1dPictureDataComponentOffset>,
        _top: *const FFISafe<CdefTop>,
        _bottom: *const FFISafe<CdefBottom>,
    ) -> ();

    fn cdef_dir(
        dst_ptr: *const DynPixel,
        dst_stride: ptrdiff_t,
        variance: &mut c_uint,
        bitdepth_max: c_int,
        _dst: *const FFISafe<Rav1dPictureDataComponentOffset>,
    ) -> c_int;

    fn padding(
        tmp: *mut u16,
        src: *const DynPixel,
        src_stride: ptrdiff_t,
        left: *const [LeftPixelRow2px<DynPixel>; 8],
        top: *const DynPixel,
        bottom: *const DynPixel,
        h: c_int,
        edges: CdefEdgeFlags,
    ) -> ();

    fn filter(
        dst: *mut DynPixel,
        dst_stride: ptrdiff_t,
        tmp: *const u16,
        pri_strength: c_int,
        sec_strength: c_int,
        dir: c_int,
        damping: c_int,
        h: c_int,
        edges: usize,
        bitdepth_max: c_int,
    ) -> ();

    // src/mc.rs
    fn mc(
        dst_ptr: *mut DynPixel,
        dst_stride: isize,
        src_ptr: *const DynPixel,
        src_stride: isize,
        w: i32,
        h: i32,
        mx: i32,
        my: i32,
        bitdepth_max: i32,
        _dst: *const FFISafe<Rav1dPictureDataComponentOffset>,
        _src: *const FFISafe<Rav1dPictureDataComponentOffset>,
    ) -> ();

    fn mc_scaled(
        dst_ptr: *mut DynPixel,
        dst_stride: isize,
        src_ptr: *const DynPixel,
        src_stride: isize,
        w: i32,
        h: i32,
        mx: i32,
        my: i32,
        dx: i32,
        dy: i32,
        bitdepth_max: i32,
        _dst: *const FFISafe<Rav1dPictureDataComponentOffset>,
        _src: *const FFISafe<Rav1dPictureDataComponentOffset>,
    ) -> ();

    fn warp8x8(
        dst_ptr: *mut DynPixel,
        dst_stride: isize,
        src_ptr: *const DynPixel,
        src_stride: isize,
        abcd: &[i16; 4],
        mx: i32,
        my: i32,
        bitdepth_max: i32,
        _dst: *const FFISafe<Rav1dPictureDataComponentOffset>,
        _src: *const FFISafe<Rav1dPictureDataComponentOffset>,
    ) -> ();

    fn mct(
        tmp: *mut i16,
        src_ptr: *const DynPixel,
        src_stride: isize,
        w: i32,
        h: i32,
        mx: i32,
        my: i32,
        bitdepth_max: i32,
        _src: *const FFISafe<Rav1dPictureDataComponentOffset>,
    ) -> ();

    fn mct_scaled(
        tmp: *mut i16,
        src_ptr: *const DynPixel,
        src_stride: isize,
        w: i32,
        h: i32,
        mx: i32,
        my: i32,
        dx: i32,
        dy: i32,
        bitdepth_max: i32,
        _src: *const FFISafe<Rav1dPictureDataComponentOffset>,
    ) -> ();

    fn warp8x8t(
        tmp: *mut i16,
        tmp_stride: usize,
        src_ptr: *const DynPixel,
        src_stride: isize,
        abcd: &[i16; 4],
        mx: i32,
        my: i32,
        bitdepth_max: i32,
        _tmp_len: usize,
        _src: *const FFISafe<Rav1dPictureDataComponentOffset>,
    ) -> ();

    fn avg(
        dst_ptr: *mut DynPixel,
        dst_stride: isize,
        tmp1: &[i16; COMPINTER_LEN],
        tmp2: &[i16; COMPINTER_LEN],
        w: i32,
        h: i32,
        bitdepth_max: i32,
        _dst: *const FFISafe<Rav1dPictureDataComponentOffset>,
    ) -> ();

    fn w_avg(
        dst_ptr: *mut DynPixel,
        dst_stride: isize,
        tmp1: &[i16; COMPINTER_LEN],
        tmp2: &[i16; COMPINTER_LEN],
        w: i32,
        h: i32,
        weight: i32,
        bitdepth_max: i32,
        _dst: *const FFISafe<Rav1dPictureDataComponentOffset>,
    ) -> ();

    fn mask(
        dst_ptr: *mut DynPixel,
        dst_stride: isize,
        tmp1: &[i16; COMPINTER_LEN],
        tmp2: &[i16; COMPINTER_LEN],
        w: i32,
        h: i32,
        mask: *const u8,
        bitdepth_max: i32,
        _dst: *const FFISafe<Rav1dPictureDataComponentOffset>,
    ) -> ();

    fn w_mask(
        dst_ptr: *mut DynPixel,
        dst_stride: isize,
        tmp1: &[i16; COMPINTER_LEN],
        tmp2: &[i16; COMPINTER_LEN],
        w: i32,
        h: i32,
        mask: &mut [u8; SEG_MASK_LEN],
        sign: i32,
        bitdepth_max: i32,
        _dst: *const FFISafe<Rav1dPictureDataComponentOffset>,
    ) -> ();

    fn blend(
        dst_ptr: *mut DynPixel,
        dst_stride: isize,
        tmp: *const [DynPixel; SCRATCH_INTER_INTRA_BUF_LEN],
        w: i32,
        h: i32,
        mask: *const u8,
        _dst: *const FFISafe<Rav1dPictureDataComponentOffset>,
    ) -> ();

    fn blend_dir(
        dst_ptr: *mut DynPixel,
        dst_stride: isize,
        tmp: *const [DynPixel; SCRATCH_LAP_LEN],
        w: i32,
        h: i32,
        _dst: *const FFISafe<Rav1dPictureDataComponentOffset>,
    ) -> ();

    fn emu_edge(
        bw: isize,
        bh: isize,
        iw: isize,
        ih: isize,
        x: isize,
        y: isize,
        dst: *mut [DynPixel; EMU_EDGE_LEN],
        dst_stride: isize,
        src_ptr: *const DynPixel,
        src_stride: isize,
        _src: *const FFISafe<Rav1dPictureDataComponent>,
    ) -> ();

    fn resize(
        dst: *mut DynPixel,
        dst_stride: isize,
        src_ptr: *const DynPixel,
        src_stride: isize,
        dst_w: i32,
        h: i32,
        src_w: i32,
        dx: i32,
        mx: i32,
        bitdepth_max: i32,
        _src: *const FFISafe<Rav1dPictureDataComponentOffset>,
        _dst: *const FFISafe<WithOffset<PicOrBuf<AlignedVec64<u8>>>>,
    ) -> ();

    // src/filmgrain.rs
    fn generate_grain_y(
        buf: *mut GrainLut<DynEntry>,
        data: &Dav1dFilmGrainData,
        bitdepth_max: c_int,
    ) -> ();

    fn generate_grain_uv(
        buf: *mut GrainLut<DynEntry>,
        buf_y: *const GrainLut<DynEntry>,
        data: &Dav1dFilmGrainData,
        uv: intptr_t,
        bitdepth_max: c_int,
    ) -> ();

    fn fgy_32x32xn(
        dst_row_ptr: *mut DynPixel,
        src_row_ptr: *const DynPixel,
        stride: ptrdiff_t,
        data: &Dav1dFilmGrainData,
        pw: usize,
        scaling: *const DynScaling,
        grain_lut: *const GrainLut<DynEntry>,
        bh: c_int,
        row_num: c_int,
        bitdepth_max: c_int,
        _dst_row: *const FFISafe<Rav1dPictureDataComponentOffset>,
        _src_src: *const FFISafe<Rav1dPictureDataComponentOffset>,
    ) -> ();

    fn fguv_32x32xn(
        dst_row_ptr: *mut DynPixel,
        src_row_ptr: *const DynPixel,
        stride: ptrdiff_t,
        data: &Dav1dFilmGrainData,
        pw: usize,
        scaling: *const DynScaling,
        grain_lut: *const GrainLut<DynEntry>,
        bh: c_int,
        row_num: c_int,
        luma_row_ptr: *const DynPixel,
        luma_stride: ptrdiff_t,
        uv_pl: c_int,
        is_id: c_int,
        bitdepth_max: c_int,
        _dst_row: *const FFISafe<Rav1dPictureDataComponentOffset>,
        _src_row: *const FFISafe<Rav1dPictureDataComponentOffset>,
        _luma_row: *const FFISafe<Rav1dPictureDataComponentOffset>,
    ) -> ();

    fn fgy_32x32xn_neon(
        dst: *mut DynPixel,
        src: *const DynPixel,
        stride: ptrdiff_t,
        scaling: *const DynScaling,
        scaling_shift: c_int,
        grain_lut: *const GrainLut<DynEntry>,
        offsets: &[[c_int; 2]; 2],
        h: c_int,
        clip: ptrdiff_t,
        r#type: ptrdiff_t,
        bitdepth_max: c_int,
    ) -> ();

    fn fguv_32x32xn_neon(
        dst: *mut DynPixel,
        src: *const DynPixel,
        stride: ptrdiff_t,
        scaling: *const DynScaling,
        data: &Dav1dFilmGrainData,
        grain_lut: *const GrainLut<DynEntry>,
        luma_row: *const DynPixel,
        luma_stride: ptrdiff_t,
        offsets: &[[c_int; 2]; 2],
        h: ptrdiff_t,
        uv: ptrdiff_t,
        is_id: ptrdiff_t,
        r#type: ptrdiff_t,
        bitdepth_max: c_int,
    ) -> ();

    //src/itx.rs
    fn itxfm(
        dst_ptr: *mut DynPixel,
        dst_stride: isize,
        coeff: *mut DynCoef,
        eob: i32,
        bitdepth_max: i32,
        _coeff_len: u16,
        _dst: *const FFISafe<Rav1dPictureDataComponentOffset>,
    ) -> ();

    // src/looprestoration.rs
    fn loop_restoration_filter(
        dst_ptr: *mut DynPixel,
        dst_stride: ptrdiff_t,
        left: *const LeftPixelRow<DynPixel>,
        lpf_ptr: *const DynPixel,
        w: c_int,
        h: c_int,
        params: &LooprestorationParams,
        edges: LrEdgeFlags,
        bitdepth_max: c_int,
        _dst: *const FFISafe<Rav1dPictureDataComponentOffset>,
        _lpf: *const FFISafe<DisjointMut<AlignedVec64<u8>>>,
    ) -> ();

    fn wiener_filter_h(
        dst: *mut i16,
        left: *const LeftPixelRow<DynPixel>,
        src: *const DynPixel,
        stride: ptrdiff_t,
        fh: &[i16; 8],
        w: intptr_t,
        h: c_int,
        edges: LrEdgeFlags,
        bitdepth_max: c_int,
    ) -> ();

    fn wiener_filter_v(
        dst: *mut DynPixel,
        stride: ptrdiff_t,
        mid: *const i16,
        w: c_int,
        h: c_int,
        fv: &[i16; 8],
        edges: LrEdgeFlags,
        mid_stride: ptrdiff_t,
        bitdepth_max: c_int,
    ) -> ();

    fn sgr_box3_h(
        sumsq: *mut i32,
        sum: *mut i16,
        left: *const LeftPixelRow<DynPixel>,
        src: *const DynPixel,
        stride: ptrdiff_t,
        w: c_int,
        h: c_int,
        edges: LrEdgeFlags,
    ) -> ();

    fn sgr_box_v(sumsq: *mut i32, sum: *mut i16, w: c_int, h: c_int, edges: LrEdgeFlags) -> ();

    fn sgr_calc_ab(
        a: *mut i32,
        b: *mut i16,
        w: c_int,
        h: c_int,
        strength: c_int,
        bitdepth_max: c_int,
    ) -> ();

    fn sgr_finish_filter(
        tmp: &mut Align16<[i16; 64 * 384]>,
        src: *const DynPixel,
        stride: ptrdiff_t,
        a: *const i32,
        b: *const i16,
        w: c_int,
        h: c_int,
    ) -> ();

    fn sgr_box5_h(
        sumsq: *mut i32,
        sum: *mut i16,
        left: *const LeftPixelRow<DynPixel>,
        src: *const DynPixel,
        stride: ptrdiff_t,
        w: c_int,
        h: c_int,
        edges: LrEdgeFlags,
    ) -> ();

    fn sgr_weighted1(
        dst: *mut DynPixel,
        dst_stride: ptrdiff_t,
        src: *const DynPixel,
        src_stride: ptrdiff_t,
        t1: &mut Align16<[i16; 64 * 384]>,
        w: c_int,
        h: c_int,
        wt: c_int,
        bitdepth_max: c_int,
    ) -> ();

    fn sgr_weighted2(
        dst: *mut DynPixel,
        dst_stride: ptrdiff_t,
        src: *const DynPixel,
        src_stride: ptrdiff_t,
        t1: &mut Align16<[i16; 64 * 384]>,
        t2: &mut Align16<[i16; 64 * 384]>,
        w: c_int,
        h: c_int,
        wt: &[i16; 2],
        bitdepth_max: c_int,
    ) -> ();

    fn sgr_box_row_h(
        sumsq: *mut i32,
        sum: *mut i16,
        left: *const LeftPixelRow<DynPixel>,
        src: *const DynPixel,
        w: c_int,
        edges: LrEdgeFlags,
        bitdepth_max: c_int,
    ) -> ();

    fn sgr_box35_row_h(
        sumsq3: *mut i32,
        sum3: *mut i16,
        sumsq5: *mut i32,
        sum5: *mut i16,
        left: *const LeftPixelRow<DynPixel>,
        src: *const DynPixel,
        w: c_int,
        edges: LrEdgeFlags,
        bitdepth_max: c_int,
    ) -> ();

    fn sgr_box_vert(
        sumsq: *mut *mut i32,
        sum: *mut *mut i16,
        aa: *mut i32,
        bb: *mut i16,
        w: c_int,
        s: c_int,
        bitdepth_max: c_int,
    ) -> ();

    fn sgr_finish_weighted1(
        dst: *mut DynPixel,
        a_ptrs: *mut *mut i32,
        b_ptrs: *mut *mut i16,
        w: c_int,
        w1: c_int,
        bitdepth_max: c_int,
    ) -> ();

    fn sgr_finish_weighted2(
        dst: *mut DynPixel,
        stride: ptrdiff_t,
        a_ptrs: *mut *mut i32,
        b_ptrs: *mut *mut i16,
        w: c_int,
        h: c_int,
        w1: c_int,
        bitdepth_max: c_int,
    ) -> ();

    fn sgr_finish_filter_2rows(
        tmp: *mut i16,
        src: *const DynPixel,
        src_stride: ptrdiff_t,
        a_ptrs: *mut *mut i32,
        b_ptrs: *mut *mut i16,
        w: c_int,
        h: c_int,
        bitdepth_max: c_int,
    ) -> ();

    fn sgr_weighted2(
        dst: *mut DynPixel,
        dst_stride: ptrdiff_t,
        src: *const DynPixel,
        src_stride: ptrdiff_t,
        t1: *const i16,
        t2: *const i16,
        w: c_int,
        h: c_int,
        wt: *const i16,
        bitdepth_max: c_int,
    ) -> ();

    // src/loopfilter.rs
    fn loopfilter_sb(
        dst_ptr: *mut DynPixel,
        stride: ptrdiff_t,
        mask: &[u32; 3],
        lvl_ptr: *const [u8; 4],
        b4_stride: ptrdiff_t,
        lut: &Align16<Av1FilterLUT>,
        w: c_int,
        bitdepth_max: c_int,
        _dst: *const FFISafe<Rav1dPictureDataComponentOffset>,
        _lvl: *const FFISafe<WithOffset<&DisjointMut<Vec<u8>>>>,
    ) -> ();

    // src/ipred.rs
    fn angular_ipred(
        dst_ptr: *mut DynPixel,
        stride: ptrdiff_t,
        topleft: *const DynPixel,
        width: c_int,
        height: c_int,
        angle: c_int,
        max_width: c_int,
        max_height: c_int,
        bitdepth_max: c_int,
        _topleft_off: usize,
        _dst: *const FFISafe<Rav1dPictureDataComponentOffset>,
    ) -> ();

    fn cfl_ac(
        ac: &mut [i16; SCRATCH_AC_TXTP_LEN],
        y_ptr: *const DynPixel,
        stride: ptrdiff_t,
        w_pad: c_int,
        h_pad: c_int,
        cw: c_int,
        ch: c_int,
        _y: *const FFISafe<Rav1dPictureDataComponentOffset>,
    ) -> ();

    fn cfl_pred(
        dst_ptr: *mut DynPixel,
        stride: ptrdiff_t,
        topleft: *const DynPixel,
        width: c_int,
        height: c_int,
        ac: &[i16; SCRATCH_AC_TXTP_LEN],
        alpha: c_int,
        bitdepth_max: c_int,
        _topleft_off: usize,
        _dst: *const FFISafe<Rav1dPictureDataComponentOffset>,
    ) -> ();

    fn pal_pred(
        dst_ptr: *mut DynPixel,
        stride: ptrdiff_t,
        pal: *const [DynPixel; 8],
        idx: *const u8,
        w: c_int,
        h: c_int,
        _dst: *const FFISafe<Rav1dPictureDataComponentOffset>,
    ) -> ();

    fn z13_fill(
        dst: *mut DynPixel,
        stride: ptrdiff_t,
        topleft: *const DynPixel,
        width: c_int,
        height: c_int,
        dxy: c_int,
        max_base_xy: c_int,
    ) -> ();

    fn z2_fill(
        dst: *mut DynPixel,
        stride: ptrdiff_t,
        top: *const DynPixel,
        left: *const DynPixel,
        width: c_int,
        height: c_int,
        dx: c_int,
        dy: c_int,
    ) -> ();

    fn z1_upsample_edge(
        out: *mut DynPixel,
        hsz: c_int,
        in_0: *const DynPixel,
        end: c_int,
        _bitdepth_max: c_int,
    ) -> ();

    fn z1_filter_edge(
        out: *mut DynPixel,
        sz: c_int,
        in_0: *const DynPixel,
        end: c_int,
        strength: c_int,
    ) -> ();

    fn z2_upsample_edge(
        out: *mut DynPixel,
        hsz: c_int,
        in_0: *const DynPixel,
        _bitdepth_max: c_int,
    ) -> ();

    fn reverse(dst: *mut DynPixel, src: *const DynPixel, n: c_int) -> ();

    // src/refmvs.rs
    fn load_tmvs(
        rf: &AsmRefMvsFrame,
        tile_row_idx: i32,
        col_start8: i32,
        col_end8: i32,
        row_start8: i32,
        row_end8: i32,
        _rp_proj: *const FFISafe<DisjointMut<AlignedVec64<RefMvsTemporalBlock>>>,
        _rp_ref: *const FFISafe<[Option<DisjointMutArcSlice<RefMvsTemporalBlock>>; 7]>,
    ) -> ();

    fn save_tmvs(
        rp_ptr: *mut RefMvsTemporalBlock,
        stride: isize,
        rr: &[*const RefMvsBlock; 31],
        ref_sign: &[u8; 7],
        col_end8: i32,
        row_end8: i32,
        col_start8: i32,
        row_start8: i32,
        _r: *const FFISafe<DisjointMut<AlignedVec64<RefMvsBlock>>>,
        _ri: &[usize; 31],
        _rp: *const FFISafe<DisjointMutArcSlice<RefMvsTemporalBlock>>,
    ) -> ();

    fn splat_mv(
        rr: *mut *mut RefMvsBlock,
        rmv: &Align16<RefMvsBlock>,
        bx4: i32,
        bw4: i32,
        bh4: i32,
    ) -> ();

}
