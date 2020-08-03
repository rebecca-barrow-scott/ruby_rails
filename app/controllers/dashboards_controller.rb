class DashboardsController < ApplicationController
    def new
        insert_data
        redirect_to dashboard_path
    end
    
    def index
        @db_users = User.all
    end

    def destroy
        User.delete_all
        insert_data
        redirect_to welcome_index_path
    end

    private def insert_data
        users = [User.new(:first_name => "John", :last_name => "Doe", :dob => "01/01/1990", :gender => "Male", :city => "Cairns"),
                 User.new(:first_name => "Jane", :last_name => "Doe", :dob => "31/12/1990", :gender => "Female", :city => "Brisbane"),
                 User.new(:first_name => "Bob", :last_name => "Scott", :dob => "28/02/1981", :gender => "Male", :city => "Toowoomba"),
                 User.new(:first_name => "Fred", :last_name => "Scott", :dob => "27/10/1985", :gender => "Male", :city => "Gold Coast"),
                 User.new(:first_name => "Mary", :last_name => "Smith", :dob => "10/09/1985", :gender => "Female", :city => "Gold Coast")]
        for user in users do
            user.save()
        end
    end
end