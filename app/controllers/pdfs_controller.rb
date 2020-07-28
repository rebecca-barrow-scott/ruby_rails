class PdfsController < ApplicationController
    def index
        @pdf = Pdf.new
        image = MiniMagick::Image.open "articles.pdf"
        MiniMagick::Tool::Convert.new do |convert|
          convert.background "white"
          convert.flatten
          convert.density 150
          convert.quality 100
          convert << image.pages.first.path
          convert << "png8:preview.png"
        end
    end

    def show
        @pdf = Pdf.find(params[:id])
    end

    def create
      @pdf = Pdf.new(pdf_params)

      if @pdf.save
        redirect_to @pdf
      else
        render 'new'
      end
    end

    private
    def pdf_params
      params.require(:pdf).permit(:name, :pdf_file)
    end
end
