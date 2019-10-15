require 'bcrypt'

# META WEBSITE PORTFOLIO AND AWARDS
awards = [
    [
        'corporate',
        'burj khalifa',
        'burj-khalifa'
    ],
    [
        'residential',
        'immeuble roussin',
        'residential-1'
    ],[
        'award',
        'speed award nominee',
        'award1-fastest'
    ],[
        'award',
        'emergency award nominee',
        'award3-emergency'
    ],[
        'residential',
        'immeuble latulipe',
        'residential-2'
    ],[
        'corporate',
        'eiffel tower',
        'eiffel-tower'
    ],[
        'award',
        'software elevators award nominee',
        'award2-techno'
    ],[
        'residetial',
        'immeuble lb9',
        'residential-3'
    ],[
        'corporate',
        'centre videotron',
        'centre-videotron'
    ],[
        'residential',
        'le quartier vision',
        'residential-4'
    ],[
        'corporate',
        'the us pentagone',
        'pentagone'
    ],[
        'corporate',
        'empire state building',
        'empire-state-building'
    ]
    
]

awards.each do |award|
    Award.create({building_type: award[0], building_name: award[1], building_file: award[2]});
end

# META WEBSITE NEWS

news =  [
    [
        "https://www.theguardian.com/commentisfree/2019/sep/05/new-york-fear-elevators",
        "https://i.guim.co.uk/img/media/11cbf448606a7ebca2e5fbc55bb7598ce8fbef22/0_231_6000_3600/master/6000.jpg?width=300&quality=85&auto=format&fit=max&s=833c8722e0c1dfdc52038f7fe30512f7",
        "Rocket Elevators Launch in Europe",
        "Europe is a new market. We, as a Team, will begin to provide our expertise in Paris, Berlin and London"
    ],[
        "https://www.producer.com/2019/09/ph-to-buy-louis-dreyfus-elevators/",
        "https://d31029zd06w0t6.cloudfront.net/wp-content/uploads/sites/54/2019/09/web1_Schroeder-Lee-RGB.jpg",
        "Thanks to Mr. Price",
        "The CEO of Rocket Elevators will pursuit his dreams to fly in the sky, say welcome to the new one coming"
    ],[
        "https://www.barrons.com/articles/otis-elevator-stock-united-technologies-split-51567546279",
        "assets/david.jpg",
        "Say Hi to the new CEO !",
        "As Mr Price has gone to the jungle we found a precious leader for the company. He has vision and leadership !"
    ],[
        "https://ny.curbed.com/2019/9/4/20849423/nycha-elevators-public-housing-city-council",
        "assets/mohammed.jpg",
        "New Employee of the month",
        "Yet another round of applause the Mohammed. He repeatedly ranked on top players in his duty at work"
    ],[
        "https://www.businessinsider.com/report-after-elevator-crushes-man-nyc-tenant-rent-strike-2019-9",
        "https://amp.businessinsider.com/images/5d6e75e32e22af71fc7f68f3-1334-1001.jpg",
        "New Tech in Elevators Industries, patented by Rocket Rlrvators",
        "A new way to climb stories, meet our teleportation portal. Launch in 2025"
    ],[
        "https://famousbusinessman.com/2019/09/08/global-residential-elevators-market-2/",
        "https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/space-elevator-1567182025.jpg?resize=3840:*",
        "New Patent By RocketElevators",
        "We can now send good to the ISS. New Elevators that can go in space !"   
    ]
]

news.each do |new|
    New.create({ link_src: new[0], image_src: new[1], title: new[2], p: new[3]})
end


# META WEBISTE CLIENTS
clients =  [
    [
        "https://cdn.worldvectorlogo.com/logos/iata-1.svg",
        "iata"
    ],[
        "https://cdn.worldvectorlogo.com/logos/emmis-communications.svg",
        "ammis"
    ],[
        "https://cdn.worldvectorlogo.com/logos/hunkemoller.svg",
        "hunkmoller"
    ],[
        "https://cdn.worldvectorlogo.com/logos/klm-4.svg",
        "kim"
    ],[
        "https://cdn.worldvectorlogo.com/logos/boiron-27692.svg",
        "boiron"
    ],[
        "https://cdn.worldvectorlogo.com/logos/au-la-plata-buenos-aires.svg",
        "alpba"
    ],[
        "https://cdn.worldvectorlogo.com/logos/designer-shoe-warehouse.svg",
        "dsw"
    ],[
        "https://cdn.worldvectorlogo.com/logos/advanta.svg",
        "advanta"
    ],[
        "https://cdn.worldvectorlogo.com/logos/salling-bank.svg",
        "salling"
    ],[
        "https://cdn.worldvectorlogo.com/logos/buick-5.svg",
        "buick"
    ],[
        "https://cdn.worldvectorlogo.com/logos/sensient.svg",
        "sansient"
    ],[
        "https://cdn.worldvectorlogo.com/logos/decibel-first.svg",
        "decbel"
    ]
]

clients.each do |client|
    Client.create({image_src: client[0], name: client[1]})
end

# META WEBSITE NAVS
navs =  [
    ["home", "top"],
    ["services", 'services'],
    ['portfolio', 'awards-projects'],
    ['news', 'news'],
    ['clients', 'clients'],
    ['contact', 'contact']
]

navs.each do |nav|
    Nav.create({title: nav[0], id_name: nav[1]})
end




# EMPLOYEES AND USERS
employees = [
    {firstname: 'Nicolas', lastname: 'Genest', title: 'Comm rep', email: 'nicolas.genest@codeboxx.biz'},
    {firstname: 'David', lastname: 'Boutin', title: 'Engineer', email: 'david.boutin@codeboxx.biz'},
    {firstname: 'Remi', lastname: 'Gagnon', title: 'Engineer', email: 'remi.gagnon@codeboxx.biz'},
    {firstname: 'Mathieu', lastname: 'Lefrancois', title: 'Engineer', email: 'mathieu.lefrancois@codeboxx.biz'},
    {firstname: 'Mathieu',lastname: 'Lortie', title: 'Engineer', email: 'mathieu.lortie@codeboxx.biz'},
    {firstname: 'Mathieu', lastname: 'Houde', title: 'Engineer', email: 'mathieu.houde@codeboxx.biz'},
    {firstname: 'Serge', lastname: 'Savoie', title: 'Engineer',  email: 'serge.savoie@codeboxx.biz'},
    {firstname: 'Nadya', lastname: 'Fortier', title: 'Director', email: 'nadya.fortier@codeboxx.biz'},
    {firstname: 'Martin', lastname: 'Chantal', title: 'Engineer', email: 'martin.chantal@codeboxx.biz'}
}

employees.each do |employee|
    createEmployee(employee)
end

def createEmployee(employee)
    @employee = Employee.new(employee)
    @employee.user.build({email: employee.email, BCrypt::Password.create(12345678)})
    
    if @mod1.try(:save)
      puts 'employee saved'
    else
      puts 'no saved'
    end
end