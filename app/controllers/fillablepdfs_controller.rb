class FillablepdfsController < ApplicationController
    def index
        @fillablepdf = Fillablepdf.new
    end

    def show
        @fillablepdf = Fillablepdf.find(params[:id])
        image = MiniMagick::Image.open @fillablepdf.pdf_file
    end

    def create
        @fillablepdf = Fillablepdf.new(pdf_params)
  
        if @fillablepdf.save
          redirect_to @fillablepdf
        else
          render 'new'
        end
      end
  
      private
      def pdf_params
        params.require(:fillablepdf).permit(:name, :pdf_file)
      end
end
