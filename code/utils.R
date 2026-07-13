# Function to generate gif if using CRAN version of tourr
render_gif <- function(data, tour_path, display,
                       gif_file = "animation.gif", ...,
                       apf = 1/5, frames = 50,
                       rescale = TRUE, sphere = FALSE,
                       start = NULL, loop = TRUE) {

  if (!requireNamespace("gifski", quietly = TRUE)) {
    stop("To use this function please install the 'gifski' package", quietly = TRUE)
  }

  # temp png files
  dir <- tempdir()
  png_path <- file.path(dir, "frame%03d.png")

  render(data = data,
         tour_path = tour_path,
         display = display,
         dev = "png",
         png_path,
         ...,
         apf = apf,
         frames = frames,
         rescale = rescale,
         sphere = sphere,
         start = start
  )

  png_files <- sprintf(png_path, 1:frames)
  on.exit(unlink(png_files))

  gifski::gifski(png_files, gif_file, delay = apf, loop = loop, progress = TRUE, ...)
}

# Render manual
render_manual <- function(data, mtour, gif_file,
                          col=NULL, pch=16, cex=1.5,
                          half_range=3, axes="center", axes_scale=1,
                          apf = 1/10, loop = FALSE,
                          dir = temp_dir()) {
  d <- dim(mtour)

  # temp png files
  png_path <- file.path(dir, "frame%03d.png")
  png(png_path)

  for (i in 1:d[3]) {
    fp <- as.matrix(data) %*%
      matrix(mtour[,,i], ncol=d[2])
    fp <- tourr::center(fp)
    colnames(fp) <- c("d1", "d2")

    par(pty = "s", mar = rep(0.1, 4))
    tourr:::blank_plot(xlim = c(-1, 1), ylim = c(-1, 1))
    tourr:::draw_tour_axes(mtour[,,i], labels=colnames(data), limits = axes_scale, axes)
    fp <- fp / half_range
    points(fp, col = col, pch = pch, cex = cex)
  }

  png_files <- sprintf(png_path, 1:d[3])
  on.exit(unlink(png_files))

  gifski::gifski(png_files, gif_file, delay = apf, loop = loop, progress = TRUE)
}
