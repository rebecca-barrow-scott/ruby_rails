class PdfsController < ApplicationController
    def index
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
      params.require(:pdf).permit(:name)
    end
end
