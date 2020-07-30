class FillablepdfsController < ApplicationController
    def index
        @fillablepdf = Fillablepdf.new
    end

    def show
        @fillablepdf = Fillablepdf.find(params[:id])
        @content = {}
        field_name = ''
        field_value = ''
        File.foreach('C:\Users\rebec\Documents\Program_1_rails\blog\app\assets\pdf\content\content.txt') { |line|
          split_line = line.split(": ")
          if split_line[0] == "FieldName"
            text = split_line[1].split("\n")
            field_name = text
          end
          if split_line[0] == "FieldValue"
            text = split_line[1].split("\n")
            field_value = text[0]
          end
          @content[field_name] = field_value
          @content.map do |key, value|
            if key == "" or key == nil or value=="" or value==nil
              @content.delete(key)
            end
          end
        }
    end

    def create
        @fillablepdf = Fillablepdf.new(pdf_params)
        @pdftk = ActivePdftk::Wrapper.new
        @pdftk.dump_data_fields('C:\Users\rebec\Downloads\filled_form.pdf', :output => 'C:\Users\rebec\Documents\Program_1_rails\blog\app\assets\pdf\content\content.txt')  
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
