class DashboardsController < ApplicationController
    def new
        extra_data
        UserEvent.delete_all
        insert_user_event(User.all, Event.all)
        redirect_to welcome_index_path
    end
    
    def index
        @db_users = User.all
        @ages = age
        @db_events = Event.all
        @db_user_events = UserEvent.all
        @refined_ue = refine_user_events(@db_events, @db_user_events)
    end

    def show
        @db_users = User.all
    end

    def destroy
        @refined_ue = []
        User.delete_all
        Event.delete_all
        UserEvent.delete_all
        insert_data
        create_events
        insert_user_event(User.all, Event.all)
        redirect_to welcome_index_path
    end

    private def insert_data
        users = [User.new(:first_name => "John", :last_name => "Doe", :dob => "01/01/1990", :gender => "Male", :city => "Cairns"),
                 User.new(:first_name => "Jane", :last_name => "Doe", :dob => "31/12/1990", :gender => "Female", :city => "Brisbane"),
                 User.new(:first_name => "Bob", :last_name => "Scott", :dob => "28/02/1991", :gender => "Male", :city => "Toowoomba"),
                 User.new(:first_name => "Fred", :last_name => "Scott", :dob => "27/10/1995", :gender => "Male", :city => "Gold Coast"),
                 User.new(:first_name => "Mary", :last_name => "Smith", :dob => "10/09/1995", :gender => "Female", :city => "Gold Coast")]
        for user in users do
            user.save()
        end
    end
    private def age
        ages = {}
        @db_users.each do |user|
            year = user.dob.year
            user_age = 2020 - year
            if ages.has_key?(user_age)
                ages[user_age] += 1
            else 
                ages[user_age] = 1
            end
        end
        return ages
    end

    private def extra_data
        female_first_names = ['Anne', 'Jess', 'Amanda', 'Sabrina', 'Rose', 'Olivia', 'Ava', 'Emma', 'Lorraine', 'Mia']
        male_first_names = ['Kyle', 'Michael', 'Travis', 'Rhys', 'Liam', 'Noah', 'William', 'James', 'Luke', 'James']
        last_names = ['Johnson', 'Williams', 'Robertson', 'Brown', 'Jones', 'Miller', 'Davis', 'Astor', 'Windsor', 'Wilson']
        dob = ['14/10/1993', '23/11/1992', '10/12/1995', '16/01/1999', '24/02/2000', '28/03/2001', '30/04/2002', '19/05/1998', '21/06/1996', '11/07/1993']
        gender = ['Female', 'Male']
        city = ['Gold Coast', 'Toowoomba', 'Cairns', 'Brisbane', 'Ipswich', 'Springfield', 'Warwick', 'Gympie', 'Burleigh Heads', 'Beaudesert']
        extra_users = []
        for i in 0..4
            user = User.new
            numbers = [rand(2), rand(10), rand(10), rand(10), rand(10)]
            user.gender = gender[numbers[0]]
            if user.gender == "Female"
                user.first_name = female_first_names[numbers[1]]
            else
                user.first_name = male_first_names[numbers[1]]
            end
            user.last_name = last_names[numbers[2]]
            user.dob = dob[numbers[3]]
            user.city = city[numbers[4]]
            extra_users.append(user)
        end
        for user in extra_users do
            user.save()
        end
    end

    private def create_events
        events = [Event.new(:name => "Schoolies", :location => "Gold Coast"), 
                  Event.new(:name => "Education", :location => "Toowoomba"),
                  Event.new(:name => "Splendor", :location => "Byron Bay"), 
                  Event.new(:name => "The Ashes", :location => "Woolloongabba")]
        for event in events do 
            event.save()
        end
    end

    private def insert_user_event(users, events)
        user_events = []
        users.each do |user|
            numbers = [rand(4), rand(4), rand(4)]
            for number in numbers do
                user_events.append(UserEvent.new(:user_id => user.id, :event_id => events[number].id))
            end
        end 
        for user_event in user_events do
            user_event.save()
        end
    end

    private def refine_user_events(events, user_events)
        refined_ue = {}
        for user_event in user_events do
            for event in events do 
                if user_event.event_id == event.id
                    if refined_ue.has_key?(event.name)
                        refined_ue[event.name] += 1
                    else 
                        refined_ue[event.name] = 1
                    end
                end
            end 
        end
        return refined_ue
    end
end