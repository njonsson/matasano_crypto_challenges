require 'matasano_crypto_challenges/set_01/challenge_07'
require 'matasano_crypto_challenges/representations/base64'

describe MatasanoCryptoChallenges::Set01::Challenge07 do
  subject(:challenge_07) { challenge_07_class.new }

  let(:challenge_07_class) { described_class }

  describe '#decrypt_aes128_ecb' do
    let(:ciphertext_base64_string) {
      <<-end_ciphertext_base64_string.gsub(/\s+/, '')
        CRIwqt4+szDbqkNY+I0qbDe3LQz0wiw0SuxBQtAM5TDdMbjCMD/venUDW9BLPEXODbk6a48oM
        bAY6DDZsuLbc0uR9cp9hQ0QQGATyyCESq2NSsvhx5zKlLtzdsnfK5ED5srKjK7Fz4Q38/ttd+
        stL/9WnDzlJvAo7WBsjI5YJc2gmAYayNfmCW2lhZE/ZLG0CBD2aPw0W417QYb4cAIOW92jYRi
        J4PTsBBHDe8o4JwqaUac6rqdi833kbyAOV/Y2RMbN0oDb9Rq8uRHvbrqQJaJieaswEtMkgUt3
        P5Ttgeh7J+hE6TR0uHot8WzHyAKNbUWHoi/5zcRCUipvVOYLoBZXlNu4qnwoCZRSBgvCwTdz3
        Cbsp/P2wXB8tiz6l9rL2bLhBt13Qxyhhu0H0+JKj6soSeX5ZD1Rpilp9ncR1tHW8+uurQKyXN
        4xKeGjaKLOejr2xDIw+aWF7GszU4qJhXBnXTIUUNUfRlwEpS6FZcsMzemQF30ezSJHfpW7DVH
        zwiLyeiTJRKoVUwo43PXupnJXDmUysCa2nQz/iEwyor6kPekLv1csm1Pa2LZmbA9Ujzz8zb/g
        FXtQqBAN4zA8/wt0VfoOsEZwcsaLOWUPtF/Ry3VhlKwXE7gGH/bbShAIKQqMqqUkEucZ3HPHA
        Vp7ZCn3Ox6+c5QJ3Uv8V7L7SprofPFN6F+kfDM4zAc59do5twgDoClCbxxG0L19TBGHiYP3Cy
        geY1HLMrX6KqypJfFJW5O9wNIF0qfOC2lWFgwayOwq41xdFSCW0/EBSc7cJw3N06WThrW5Lim
        AOt5L9c7Ik4YIxu0K9JZwAxfcU4ShYu6euYmWLP98+qvRnIrXkePugS9TSOJOHzKUoOcb1/KY
        d9NZFHEcp58Df6rXFiz9DSq80rR5Kfs+M+Vuq5Z6zY98/SP0A6URIr9NFu+Cs9/gf+q4TRwsO
        zRMjMQzJL8f7TXPEHH2+qEcpDKz/5pE0cvrgHr63XKu4XbzLCOBz0DoFAw3vkuxGwJq4Cpxkt
        +eCtxSKUzNtXMn/mbPqPl4NZNJ8yzMqTFSODS4bYTBaN/uQYcOAF3NBYFd5x9TzIAoW6ai13a
        8h/s9i5FlVRJDe2cetQhArrIVBquF0L0mUXMWNPFKkaQEBsxpMCYh7pp7YlyCNode12k5jY1/
        lc8jQLQJ+EJHdCdM5t3emRzkPgND4a7ONhoIkUUS2R1oEV1toDj9iDzGVFwOvWyt4GzA9XdxT
        333JU/n8m+N6hs23MBcZ086kp9rJGVxZ5f80jRz3ZcjU6zWjR9ucRyjbsuVn1t4EJEm6A7KaH
        m13m0vwN/O4KYTiiY3aO3siayjNrrNBpn1OeLv9UUneLSCdxcUqjRvOrdA5NYv25Hb4wkFCIh
        C/Y2ze/kNyis6FrXtStcjKC1w9Kg8O25VXB1Fmpu+4nzpbNdJ9LXahF7wjOPXN6dixVKpzwTY
        jEFDSMaMhaTOTCaqJig97624wv79URbCgsyzwaC7YXRtbTstbFuEFBee3uW7B3xXw72mymM2B
        S2uPQ5NIwmacbhta8aCRQEGqIZ078YrrOlZIjar3lbTCo5o6nbbDq9bvilirWG/SgWINuc3pW
        l5CscRcgQQNp7oLBgrSkQkv9AjZYcvisnr89TxjoxBO0Y93jgp4T14LnVwWQVx3l3d6S1wlsc
        idVeaM24E/JtS8k9XAvgSoKCjyiqsawBMzScXCIRCk6nqX8ZaJU3rZ0LeOMTUw6MC4dC+aY9S
        rCvNQub19mBdtJUwOBOqGdfd5IoqQkaL6DfOkmpnsCs5PuLbGZBVhah5L87IY7r6TB1V7KboX
        H8PZIYc1zlemMZGU0o7+etxZWHgpdeX6JbJIs3ilAzYqw/Hz65no7eUxcDg1aOaxemuPqnYRG
        hW6PvjZbwAtfQPlofhB0jTHt5bRlzF17rn9q/6wzlc1ssp2xmeFzXoxffpELABV6+yj3gfQ/b
        xIB9NWjdZK08RX9rjm9CcBlRQeTZrD67SYQWqRpT5t7zcVDnx1s7ZffLBWm/vXLfPzMaQYEJ4
        EfoduSutjshXvR+VQRPs2TWcF7OsaE4csedKUGFuo9DYfFIHFDNg+1PyrlWJ0J/X0PduAuCZ+
        uQSsM/ex/vfXp6Z39ngq4exUXoPtAIqafrDMd8SuAtyEZhyY9V9Lp2qNQDbl6JI39bDz+6pDm
        jJ2jlnpMCezRK89cG11IqiUWvIPxHjoiT1guH1uk4sQ2Pc1J4zjJNsZgoJDcPBbfss4kAqUJv
        QyFbzWshhtVeAv3dmgwUENIhNK/erjpgw2BIRayzYw001jAIF5c7rYg38o6x3YdAtU3d3Qpuw
        G5xDfODxzfL3yEKQr48C/KqxI87uGwyg6H5gc2AcLU9JYt5QoDFoC7PFxcE3RVqc7/Um9Js9X
        9UyriEjftWt86/tEyG7F9tWGxGNEZo3MOydwX/7jtwoxQE5ybFjWndqLp8DV3naLQsh/Fz8Jn
        TYHvOR72vuiw/x5D5PFuXV0aSVvmw5Wnb09q/BowS14WzoHH6ekaWbh78xlypn/L/M+nIIEX1
        Ol3TaVOqIxvXZ2sjm86xRz0EdoHFfupSekdBULCqptxpFpBshZFvauUH8Ez7wA7wjL65GVlZ0
        f74U7MJVu9SwsZdgsLmnsQvr5n2ojNNBEv+qKG2wpUYTmWRaRc5EClUNfhzh8iDdHIsl6edOe
        wORRrNiBay1NCzlfz1cj6VlYYQUM9bDEyqrwO400XQNpoFOxo4fxUdd+AHmCBhHbyCR81/C6L
        QTG2JQBvjykG4pmoqnYPxDyeiCEG+JFHmP1IL+jggdjWhLWQatslrWxuESEl3PEsrAkMF7gt0
        dBLgnWsc1cmzntG1rlXVi/Hs2TAU3RxEmMSWDFubSivLWSqZj/XfGWwVpP6fsnsfxpY3d3h/f
        TxDu7U8GddaFRQhJ+0ZOdx6nRJUW3u6xnhH3mYVRk88EMtpEpKrSIWfXphgDUPZ0f4agRzehk
        n9vtzCmNjFnQb0/shnqTh4Mo/8oommbsBTUKPYS7/1oQCi12QABjJDt+LyUan+4iwvCi0k0IU
        IHvk21381vC0ixYDZxzY64+xx/RNID+iplgzq9PDZgjc8L7jMg+2+mrxPS56e71m5E2zufZ4d
        +nFjIg+dHD/ShNPzVpXizRVUERztLuak8Asah3/yvwOrH1mKEMMGC1/6qfvZUgFLJH5V0Ep0n
        2K/Fbs0VljENIN8cjkCKdG8aBnefEhITdV7CVjXcivQ6efkbOQCfkfcwWpaBFC8tD/zebXFE+
        JshW16D4EWXMnSm/9HcGwHvtlAj04rwrZ5tRvAgf1IR83kqqiTvqfENcj7ddCFwtNZrQK7EJh
        gB5Tr1tBFcb9InPRtS3KYteYHl3HWR9t8E2YGE8IGrS1sQibxaK/C0kKbqIrKpnpwtoOLsZPN
        bPw6K2jpko9NeZAx7PYFmamR4D50KtzgELQcaEsi5aCztMg7fp1mK6ijyMKIRKwNKIYHagRRV
        LNgQLg/WTKzGVbWwq6kQaQyArwQCUXo4uRtyzGMaKbTG4dns1OFB1g7NCiPb6s1lv0/lHFAF6
        HwoYV/FPSL/pirxyDSBb/FRRA3PIfmvGfMUGFVWlyS7+O73l5oIJHxuaJrR4EenzAu4Avpa5d
        +VuiYbM10aLaVegVPvFn4pCP4U/Nbbw4OTCFX2HKmWEiVBB0O3J9xwXWpxN1Vr5CDi75FqNhx
        YCjgSJzWOUD34Y1dAfcj57VINmQVEWyc8Tch8vg9MnHGCOfOjRqp0VGyAS15AVD2QS1V6fhRi
        mJSVyT6QuGb8tKRsl2N+a2Xze36vgMhw7XK7zh//jC2H
      end_ciphertext_base64_string
    }

    let(:key) { 'YELLOW SUBMARINE' }

    let(:expected_plaintext_base64_string) {
      MatasanoCryptoChallenges::Representations::Base64.from_string(expected_plaintext).value
    }

    let(:expected_plaintext) {
      <<-end_expected_plaintext.gsub(/^ +/, '')
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
      actual = challenge_07.decrypt_aes128_ecb(ciphertext_base64_string: ciphertext_base64_string,
                                               key_string:               key)
      expect(actual).to eq(expected_plaintext_base64_string)
    }
  end
end
