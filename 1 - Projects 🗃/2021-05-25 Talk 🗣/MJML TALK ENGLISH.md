# Introduction to MJML
Hey today I'm going to talk to you about MJML. 
What is MJML? 
MJML is a framework that will help you do design email.  (SLIDE)
You will write less, you will save some time and your Code will be more efficient.
But first, let me introduce to you ! (SLIDE)
I'm Isabelle, I'm a junior freelance full stack web developper.
But before that, I worked for more than 14 years as an Assistant camera operator (you know, on a movie set, the one that are making the focus).

But As long as I can remember, I always have been interested in web developement and something inside me tells me that it was time to change carreer ! 

So after having following training course with Freecode camp or CodeCademy, I've decided to join the Bootcamp "LE WAGON" in 2020. 
Soon after, I became a Teacher Assistant in LE WAGON and I join the JOGL team, a Non governmental organization, first as a volunteer and then as a freelancer. 

And one of the first task that I had to do in JOGL was to help to implement recommendations emails ! 
you see where I'm going right ? 
I had to write emails ! 
And As a web developers, Writing and Designing emails can be really complicated ! (Slide)
because you have to follow some rules ! 
The first one is : HTML and CSS has to be in the same file ! The code can really be messy ! 

It has to be responsive !! and work for different kind of device (from desktop, to tablets and of course mobile phone !)

It should work with email clients like OUtlook, Gmail, Aplle.. the list can be really long ! 

And you have to be working with HTML Table !! 
Who's working with table anymore ? I mean now you can use Grid or flexbox to achieve the same thing, so you do not really need to use table !

That's something right ? But hopefully for web developers and for me, MJML Exists! 

So WHY CHOOSE MJML TO design Email ? 

Because It's easy and quick ! 
It's Responsive ! 
It's Component Based ! 
So you can write reusable code and extensive components. 
Sounds perfect right ?  (slide) 

How to design email with MJML ? 
So first you had to install it of course (don't forget to add the node files in the gitignore file of your project)
and then you had to set up your config/initializers file. 

Then you have to set up your mailer 

the Views / layouts 

I could show you lot of code snippets to explain you how MJML is working but I just think, it would more fun if we code a template together ! 

So let's try it online !

```ruby
<mjml>

  <mj-head>
    <mj-attributes>
      <mj-text padding="10px"/>
      <mj-class name="text" font-family="roboto" font-size="15px" align="center"/>
      <mj-class name="text-footer" color="#232323" font-size="13px" padding="10px 20px 20px 20px"/>
    </mj-attributes>

    <mj-style>
      .card-shadow {
      -moz-box-shadow: 0px 0px 20px 0px rgba(0,0,0,0.12);
      -webkit-box-shadow: 0px 0px 20px 0px rgba(0,0,0,0.12);
      box-shadow: 0px 0px 20px 0px rgba(0,0,0,0.12);
      -moz-border-radius: 12px;
      -webkit-border-radius: 12px;
      border-radius: 12px;
      }
    </mj-style>
  </mj-head>

  <mj-body>
    <mj-section>
      <mj-column>

        <mj-image width="120px" src="https://pbs.twimg.com/profile_images/1369291363238428676/qUkr-m-h_400x400.jpg"></mj-image>

        <mj-divider border-color="#f56961"></mj-divider>

        <mj-text font-size="24px" color="#f56961" font-family="roboto" align="center">Hello Ruby World</mj-text>

      </mj-column>
    </mj-section>

    <mj-section padding="15px">
      <mj-column css-class="card-shadow">
        <mj-text mj-class="text">
           Welcome to the May event's with Isabelle Lafont!
          <br/> Today we're going to introduce you to the MJML Framework to help you design email.
        </mj-text>
        <mj-text mj-class="text">
           Here's look at this beautiful photos !
        </mj-text>
      </mj-column>
    </mj-section>

    <mj-section>
      <mj-column>
        <mj-image width="200px" src="https://res.cloudinary.com/dy1zfz0fs/image/upload/v1592400285/10e0hkjwtljj0p7i80baurha7jk0.jpg">
        </mj-image>
        <mj-text>
           Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur sit amet ipsum consequat
        </mj-text>
        <mj-button href="#" align="center" background-color="#f56961" border-radius="20px" font-size="12px" >Click Me Now</mj-button>
      </mj-column>
      <mj-column>
        <mj-image width="200px" src="https://res.cloudinary.com/dy1zfz0fs/image/upload/v1621872227/alvan-nee-ZCHj_2lJP00-unsplash_cmafjy.jpg">
        </mj-image>
        <mj-text>
           Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur sit amet ipsum consequat
        </mj-text>
        <mj-button href="#" align="center" background-color="#f56961" border-radius="20px" font-size="12px" >Click Me Now</mj-button>
      </mj-column>
      <mj-column>
        <mj-image width="200px" src="https://res.cloudinary.com/dy1zfz0fs/image/upload/v1621872463/erik-jan-leusink---SDX4KWIbA-unsplash_rkbjjx.jpg">
        </mj-image>
        <mj-text>
           Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur sit amet ipsum consequat
        </mj-text>
        <mj-button href="#" align="center" background-color="#f56961" border-radius="20px" font-size="12px" >Click Me Now</mj-button>
      </mj-column>
    </mj-section>

    <mj-section>
      <mj-column>
        <mj-divider border-color="#f56961"></mj-divider>
      </mj-column>
    </mj-section>

    <mj-section>
      <mj-group>
        <mj-column>
          <mj-social icon-size="24px" mode="horizontal" align="center" inner-padding="16px">
            <mj-social-element name="facebook" href="#">Facebook</mj-social-element>
            <mj-social-element name="twitter" href="#">Twitter</mj-social-element>
            <mj-social-element name="instagram" href="#">Instagram</mj-social-element>
            <mj-social-element name="linkedin" href="#">Linkedin</mj-social-element>
          </mj-social>
        </mj-column>
      </mj-group>
    </mj-section>

    <mj-section padding-bottom="30px" background-color="#F3F3F3">
      <mj-column>
        <mj-text align="center" mj-class="text-footer">
           Here you can add some extra information, the address, your contact info...
        </mj-text>
      </mj-column>
    </mj-section>


  </mj-body>
</mjml>
```

==Tips to create snippet code==
Use [Carbon](https://carbon.now.sh/) to create beautiful code snippets

![[config-initializer.rb.png]]