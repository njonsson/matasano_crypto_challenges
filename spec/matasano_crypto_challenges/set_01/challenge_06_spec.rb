require 'matasano_crypto_challenges/set_01/challenge_06'
require 'matasano_crypto_challenges/representations/base64'

describe MatasanoCryptoChallenges::Set01::Challenge06 do
  subject(:challenge_06) { challenge_06_class.new }

  let(:challenge_06_class) { described_class }

  describe '#crack_multibyte_xor' do
    let(:ciphertext_base64_string) {
      <<-end_ciphertext_base64_string.gsub(/\s+/, '')
        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
        C0EbAVIqCFZBO1IdBgZUVA4QTgUWSR4QJwwRTWM=
      end_ciphertext_base64_string
    }

    let(:expected_plaintext_base64_string) {
      MatasanoCryptoChallenges::Representations::Base64.from_string(expected_plaintext).value
    }

    let(:expected_plaintext) {
      <<-end_expected_plaintext.gsub(/^ +/, '').chomp
        I'm back and I'm ringin' the bell 
        A rockin' on the mike while the fly girls yell 
        In ecstasy in the back of me 
        Well that's my DJ Deshay cuttin' all them Z's 
        Hittin' hard and the girlies goin' crazy 
        Vanilla's on the mike, man I'm not lazy. 

        I'm lettin' my drug kick in 
        It controls my mouth and I begin 
        To just let it flow, let my concepts go 
        My posse's to the side yellin', Go Vanilla Go! 

        Smooth 'cause that's the way I will be 
        And if you don't give a damn, then 
        Why you starin' at me 
        So get off 'cause I control the stage 
        There's no dissin' allowed 
        I'm in my own phase 
        The girlies sa y they love me and that is ok 
        And I can dance better than any kid n' play 

        Stage 2 -- Yea the one ya' wanna listen to 
        It's off my head so let the beat play through 
        So I can funk it up and make it sound good 
        1-2-3 Yo -- Knock on some wood 
        For good luck, I like my rhymes atrocious 
        Supercalafragilisticexpialidocious 
        I'm an effect and that you can bet 
        I can take a fly girl and make her wet. 

        I'm like Samson -- Samson to Delilah 
        There's no denyin', You can try to hang 
        But you'll keep tryin' to get my style 
        Over and over, practice makes perfect 
        But not if you're a loafer. 

        You'll get nowhere, no place, no time, no girls 
        Soon -- Oh my God, homebody, you probably eat 
        Spaghetti with a spoon! Come on and say it! 

        VIP. Vanilla Ice yep, yep, I'm comin' hard like a rhino 
        Intoxicating so you stagger like a wino 
        So punks stop trying and girl stop cryin' 
        Vanilla Ice is sellin' and you people are buyin' 
        'Cause why the freaks are jockin' like Crazy Glue 
        Movin' and groovin' trying to sing along 
        All through the ghetto groovin' this here song 
        Now you're amazed by the VIP posse. 

        Steppin' so hard like a German Nazi 
        Startled by the bases hittin' ground 
        There's no trippin' on mine, I'm just gettin' down 
        Sparkamatic, I'm hangin' tight like a fanatic 
        You trapped me once and I thought that 
        You might have it 
        So step down and lend me your ear 
        '89 in my time! You, '90 is my year. 

        You're weakenin' fast, YO! and I can tell it 
        Your body's gettin' hot, so, so I can smell it 
        So don't be mad and don't be sad 
        'Cause the lyrics belong to ICE, You can call me Dad 
        You're pitchin' a fit, so step back and endure 
        Let the witch doctor, Ice, do the dance to cure 
        So come up close and don't be square 
        You wanna battle me -- Anytime, anywhere 

        You thought that I was weak, Boy, you're dead wrong 
        So come on, everybody and sing this song 

        Say -- Play that funky music Say, go white boy, go white boy go 
        play that funky music Go white boy, go white boy, go 
        Lay down and boogie and play that funky music till you die. 

        Play that funky music Come on, Come on, let me hear 
        Play that funky music white boy you say it, say it 
        Play that funky music A little louder now 
        Play that funky music, white boy Come on, Come on, Come on 
        Play that funky music
      end_expected_plaintext
    }

    specify('returns the expected plaintext Base-64 string') {
      actual = challenge_06.crack_multibyte_xor(ciphertext_base64_string)
      expect(actual).to eq(expected_plaintext_base64_string)
    }
  end
end
