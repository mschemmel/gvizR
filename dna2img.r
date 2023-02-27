#' puts a text label on a specific position
#' @param vp_name Name of the viewport
#' @param x_ x coordinate
#' @param y_ y coordinate
#' @param w_ w coordinate
#' @param h_ h coordinate
#' @param label_txt Text to be printed on that position
#' @param angle Angle of text label
#' @param gp_ Grid parameter like font, style, color, ...
#' @examples
#' textLabel(x_ = 1, y_ = 3, w_ = 1, h_ = 1, "Test", angle = 45)

textLabel <- function(vp_name = NULL, x_, y_, w_, h_, label_txt = NULL, angle = 0, gp_ = NULL) {
    grid::pushViewport(grid::viewport(name = vp_name,
                                      x = grid::unit(x_, "npc"),
                                      y = grid::unit(y_, "npc"),
                                      width = w_,
                                      height = h_,
                                      just = c("bottom")))
    grid::grid.text(label_txt, gp = gp_, rot = angle)
    grid::popViewport(1)
}

#' plots nucleotide sequence as image
#'
#' @param sequence A nucleotide sequence string
#' @param base_colos A list of colors to be used for every nucleotide
#' return Viewport with printed nucleotide sequence
#'
#' @examples
#' dna_to_img("TATCGATCGATC", list(A = "#9EE362", T = "#00C0D0", G = "#FFD403", C = "#FF9356", U = "#d83131"))

dna2img <- function(sequence, base_colors = NULL) {
    seq_ <- unlist(strsplit(sequence, split = ""))

    if(is.null(base_colors)) {
        base_colors <- list(A = "#9EE362", T = "#00C0D0", G = "#FFD403", C = "#FF9356", U = "#d83131")
    }

    # define some constants
    ypos <- 0.95          # starting point
    ypos_spacer <- 0.05    # spacer in y direction
    xpos_spacer <- 20      # spacer in x direction

    grid::pushViewport(grid::viewport(x = 0.5, y = 0.5, width = 0.9, height = 0.9))
    count <- 1
    for (i in seq_) {
        bcol <- unlist(unname(base_colors[i]))
        xpos <- count / xpos_spacer
        if (xpos == 1) {
            count <- 1
            xpos <- count / xpos_spacer
            ypos <- ypos - ypos_spacer
        }
        textLabel(label_txt = as.character(i),
                  x_ = xpos,
                  y_ = ypos,
                  w_ = 0.01,
                  h_ = 0.1,
                  gp_ = grid::gpar(fontsize = 12, fontface = "bold", col = bcol))
        #grid::pushViewport(grid::viewport(x = x_, y = y_, width = 0.01, height = 0.1))
        count <- count + 1
    }
}