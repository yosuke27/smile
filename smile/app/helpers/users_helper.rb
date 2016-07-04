module UsersHelper
    def gravatar_for(user)
        gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
        gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
        image_tag(gravatar_url, alt: user.name, class: "gravatar")
    end
    
    def create_sample_user
        if(User.count <= 10)
            User.create(name: "sample1", email: "email1@email.com", password: "testtest", password_confirmation: "testtest");
            User.create(name: "sample2", email: "email2@email.com", password: "testtest", password_confirmation: "testtest");
            User.create(name: "sample3", email: "email3@email.com", password: "testtest", password_confirmation: "testtest");
            User.create(name: "sample4", email: "email4@email.com", password: "testtest", password_confirmation: "testtest");
            User.create(name: "sample5", email: "email5@email.com", password: "testtest", password_confirmation: "testtest");
        end
    end
    
    def create_sample_post
        Micropost.create(datecode: 20160703, user_id: 1, content: "yokatta", mood: 3, is_onechance: 1);
        Micropost.create(datecode: 20160703, user_id: 2, content: "yokatta", mood: 3, is_onechance: 1);
        Micropost.create(datecode: 20160703, user_id: 3, content: "yokatta", mood: 3, is_onechance: 1);

        Micropost.create(datecode: 20160704, user_id: 2, content: "yokatta", mood: 3, is_onechance: 1);
        Micropost.create(datecode: 20160704, user_id: 3, content: "yokatta", mood: 3, is_onechance: 1);
        Micropost.create(datecode: 20160704, user_id: 4, content: "yokatta", mood: 3, is_onechance: 1);

        Micropost.create(datecode: 20160705, user_id: 3, content: "yokatta", mood: 3, is_onechance: 1);
        Micropost.create(datecode: 20160705, user_id: 4, content: "yokatta", mood: 3, is_onechance: 1);
        Micropost.create(datecode: 20160705, user_id: 5, content: "yokatta", mood: 3, is_onechance: 1);

        Micropost.create(datecode: 20160706, user_id: 4, content: "yokatta", mood: 3, is_onechance: 1);
        Micropost.create(datecode: 20160706, user_id: 5, content: "yokatta", mood: 3, is_onechance: 1);
        Micropost.create(datecode: 20160706, user_id: 6, content: "yokatta", mood: 3, is_onechance: 1);

        Micropost.create(datecode: 20160707, user_id: 5, content: "yokatta", mood: 3, is_onechance: 1);
        Micropost.create(datecode: 20160707, user_id: 6, content: "yokatta", mood: 3, is_onechance: 1);
    end
end
