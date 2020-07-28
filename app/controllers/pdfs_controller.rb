class PdfsController < ApplicationController
    def index
        @pdf = Pdf.new
    end

    def show
        @pdf = Pdf.find(params[:id])
        image = MiniMagick::Image.open @pdf.pdf_file
        MiniMagick::Tool::Convert.new do |convert|
          convert.background "white"
          convert.flatten
          convert.density 300
          convert.quality 200
          convert.resize "600x600"
          convert << image.pages.first.path
          convert << "png8:app/assets/images/preview.png"
        end
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
