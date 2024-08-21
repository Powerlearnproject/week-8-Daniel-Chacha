    const express = require('express')
    const mysql = require('mysql2');
    const dotenv =require('dotenv');
    const bodyParser = require('body-parser');
    const { dot } = require('node:test/reporters');

    const app= express();
    dotenv.config()


    const db =mysql.createConnection({
        host: process.env.DB_HOST,
        user: process.env.DB_USERNAME,
        password: process.env.DB_PASSWORD,
        database: process.env.DB_DATABASE,
        port: process.env.DB_PORT
    })

    console.log('opening connection')
    db.connect((err) =>{
        if (err){
            console.log('Error connecting to the database' , err.stack);
            return
        }
        console.log('Database successfully connected')
    })

    function Posting_householdData(){

        const Counties = ["Mombasa","Kwale","Kilifi","Tana River","Lamu","Taita Taveta","Garissa","Wajir","Mandera","Marsabit","Isiolo","Meru","Tharaka Nithi","Embu","Kitui","Machakos","Makueni","Nyandarua","Nyeri","Kirinyaga","Murang'a","Kiambu","Nairobi","Nakuru","Narok","Baringo","Laikipia","Samburu","West Pokot","Turkana","Uasin Gishu","Trans Nzoia","Elgeyo Marakwet","Nandi","Bomet","Kakamega","Vihiga","Bungoma","Siaya","Kisumu","Homa Bay","Migori","Kisii","Nyamira"];
        const characters =['a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z']

        for(let i=0;i<500;i++){
            function randomWord(length){
                let word ='';
                for (let i=0; i<length; i++){
                    const randomIndex =Math.floor(Math.random() * characters.length);
                    word+=characters[randomIndex];
                }
                return word.charAt(0).toUpperCase() + word.slice(1);
            }

            function getRandomDate(start,end){
                const startTimestamp=start.getTime()
                const endTimestamp =end.getTime();
            
                //generate a random timestamp
                const randomTimestamp= Math.random()*(endTimestamp-startTimestamp)+startTimestamp;
                console.log(randomTimestamp)
                //convert the timestamp back to a date object
                const date= new Date(randomTimestamp);
                
                const dateString =date.toISOString().slice(0,10);
                return dateString
            }
            let household_name='The '+ randomWord(5)+ "'s";
            let no_of_occupant=Math.round(Math.random()* 10);
            let income_level=Math.round(Math.random()* 100000);
            let appliance_count=Math.round(Math.random()* 10);
            let no_of_males=Math.round(Math.random()* 10);
            let no_of_females=Math.abs(no_of_occupant-no_of_males);
            let city=Counties[Math.round(Math.random()* 10)]
            let energy_consumed=Math.round(Math.random()*100);
            let cost=energy_consumed*100 ;
            let date=getRandomDate(new Date(2023,1,1), new Date(2024,8,8))

            const addData= `INSERT INTO household_energyConsumption(HOUSEHOLD_NAME, NO_OF_OCCUPANTS, INCOME_LEVEL, APPLIANCE_COUNT, NO_OF_MALES, NO_OF_FEMALES, CITY, ENERGY_CONSUMED_kWh,COST,DATE) VALUES(?)`

            values=[household_name,no_of_occupant,income_level,appliance_count,no_of_males,no_of_females,city,energy_consumed,cost, date];

            db.query(addData, [values],(err,results) =>{
                if(err) {
                    console.error('Database Error',err)
                }
                else{
                    console.log(`Record ${i+1} Added Successfully.`)
                }
                
            })
        }
        console.log('Done');

        
    }

    Posting_householdData();
        

   

    app.listen(process.env.PORT, ()=>{
        console.log(`Server is running on port ${process.env.PORT}`)
    })