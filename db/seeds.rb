# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

if Page.all.count < 3
  Page.create([
    {
      page_name: 'about',
      page_data: '{
          "Purpose" : "The purpose of this organization shall be to advocate for maternal and child public health-related issues for all students.",

          "Goal" : "The goal will be to enhance the quality and scope of maternal and child public health by educating students and providing them with opportunities to impact the community positively.",

          "Membership Dues" : "Membership is open to any Aggie (undergraduate or graduate/ any concentration). Dues are $15 one time.",

          "Expectations" : "Attend monthly meetings, Respond in GroupMe when needed (ex. polls), Attend supplemental meetings if able, Respect opinions of fellow members",

          "What We Do" : "Field trips, Volunteering, Book club, Guest speakers, Donation drives, Profit shares, Craft events, Socials, Research opportunities, Certificate opportunities"
    }'
    },
    {
      page_name: 'contact',
      page_data: '{
          "description" : "Below you can find our email and social links, be sure to follow MCHSO on Facebook!",

          "Email" : "mailto:hannahbartosh@tamu.edu",

          "links" : {
            "facebook" : "https://www.facebook.com/MCHSOaggies/",
            "store" : "https://tamu.estore.flywire.com/products?storeCatalog=7302",
            "instagram" : "https://www.instagram.com/mchsoaggies/?hl=en"
          }
    }'

    },
    {
      page_name: 'home',
      page_data: '{

        "title" : "The Maternal and Child Health Student Organization",

        "blurb" : "Welcome blurb, summary of the history and basic information of the org."
  }'
    }
  ]
             )
end

if PointsType.all.count.zero?
  PointsType.create([
    {
      name: 'Member'
    },
    {
      name: 'Social'
    },
    {
      name: 'Philanthropy'
    }
  ]
                   )
end
