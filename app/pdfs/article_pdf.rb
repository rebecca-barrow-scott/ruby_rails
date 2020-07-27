class ArticlePdf < Prawn::Document
    def initialize(articles)
        super()
        @articles = Article.all
        articles_table
    end
    def articles_table
        table articles_info do 
            row(0).font_style = :bold
            columns(0..10).align = :center
            self.row_colors = ["DDDDDD", "FFFFFF"]
            self.header = true
        end
    end
    def articles_info
        [["title", "text"]] +
        @articles.map do |article|
            [ article.title, article.text]
        end
    end
end