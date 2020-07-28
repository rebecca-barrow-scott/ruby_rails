class PdfsController < ApplicationController
    def index
        @pdf = Pdf.new
    end

    def show
        @pdf = Pdf.find(params[:id])
        @pdf_length = 0

        def save_png_images(to_image_temp_path, index, page)
          image_file = "#{to_image_temp_path}/#{index+1}.png"
          MiniMagick::Tool::Convert.new do |convert|
            convert << page.path
            convert.resize("600X600")
            convert << image_file
          end
        end

        image = MiniMagick::Image.open @pdf.pdf_file
        image.pages.each_with_index do |page, index|
          save_png_images("app/assets/images", index, page)
          @pdf_length += 1
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
