// This is free and unencumbered software released into the public domain.
//
// Anyone is free to copy, modify, publish, use, compile, sell, or
// distribute this software, either in source code form or as a compiled
// binary, for any purpose, commercial or non-commercial, and by any
// means.

#include "firmware.h"
// Include the stats helper functions up front so they can also be used
// inside the nj* functions to profile if needed
#include "stats_helper.c"

#include "njmem.c"
// define and include for nanojpeg
#define NJ_USE_LIBC 0
#define NJ_USE_WIN32 0
#include "nanojpeg.c"

// Routines for outputing the final PPM
#include "njppmprint.c"

void hello(void)
{
	int *p = (int *)JPGBASE;
	int filesize = (*p);
	p++; 
	// njInit();    
	print_str("About to start decoding...\n");
	int t_start = get_num_cycles();
	nj_result_t res = njDecode(p, filesize);
	int t_end   = get_num_cycles();
    if (res) {
        print_str("Error! decoding the input file.\n");
    } else {
		print_str("Success!\n");
	}
	print_str("Decoded the image in ");
	print_dec(t_end - t_start);
	print_str(" cycles \n");
    t_start = get_num_cycles();
	bool colour = njIsColor();
	int width   = njGetWidth();
	int height  = njGetHeight();
    t_end   = get_num_cycles();
    print_str("Image info computed in:  ");
	print_dec(t_end - t_start);
	print_str(" cycles.\n");
	print_str(colour ? "Colour" : "Grayscale");
	print_str(" image of size ");
	print_dec(width);
	print_str(" x ");
	print_dec(height);
	print_str("\nWriting data to output.dump - \nrename this to output.ppm or output.pgm to view\n");

	ppm_print_header(colour, width, height);
	unsigned char *pc = njGetImage();
	for (int i=0; i<njGetImageSize(); i++) {
		ppm_print_chr(*pc++);
	}
	print_str("\nAll done...\n");
}

