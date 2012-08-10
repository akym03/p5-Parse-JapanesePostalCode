use strict;
use warnings;
use utf8;
use Test::More;
use t::Util;

sub run;

my $parser = make_parser
    q{07543,"97906","9790622","ﾌｸｼﾏｹﾝ","ﾌﾀﾊﾞｸﾞﾝﾄﾐｵｶﾏﾁ","ｹｶﾞﾔ(ﾏｴｶﾜﾊﾗ232-244､311､312､337-862ﾊﾞﾝﾁ","福島県","双葉郡富岡町","毛萱（前川原２３２〜２４４、３１１、３１２、３３７〜８６２番地",1,1,0,0,0,0},
    q{07543,"97906","9790622","ﾌｸｼﾏｹﾝ","ﾌﾀﾊﾞｸﾞﾝﾄﾐｵｶﾏﾁ","ﾄｳｷｮｳﾃﾞﾝﾘｮｸﾌｸｼﾏﾀﾞｲ2ｹﾞﾝｼﾘｮｸﾊﾂﾃﾞﾝｼｮｺｳﾅｲ)","福島県","双葉郡富岡町","〔東京電力福島第二原子力発電所構内〕）",1,1,0,0,0,0},

    q{01407,"04824","0482402","ﾎｯｶｲﾄﾞｳ","ﾖｲﾁｸﾞﾝﾆｷﾁｮｳ","ｵｵｴ(1ﾁｮｳﾒ､2ﾁｮｳﾒ<651､662､668ﾊﾞﾝﾁ>ｲｶﾞｲ､3ﾁｮｳﾒ5､1","北海道","余市郡仁木町","大江（１丁目、２丁目「６５１、６６２、６６８番地」以外、３丁目５、１",1,0,1,0,0,0},
    q{01407,"04824","0482402","ﾎｯｶｲﾄﾞｳ","ﾖｲﾁｸﾞﾝﾆｷﾁｮｳ","3-4､20､678､687ﾊﾞﾝﾁ)","北海道","余市郡仁木町","３−４、２０、６７８、６８７番地）",1,0,1,0,0,0},

    q{01407,"04823","0482331","ﾎｯｶｲﾄﾞｳ","ﾖｲﾁｸﾞﾝﾆｷﾁｮｳ","ｵｵｴ(2ﾁｮｳﾒ651､662､668ﾊﾞﾝﾁ､3ﾁｮｳﾒ103､118､","北海道","余市郡仁木町","大江（２丁目６５１、６６２、６６８番地、３丁目１０３、１１８、",1,0,1,0,0,0},
    q{01407,"04823","0482331","ﾎｯｶｲﾄﾞｳ","ﾖｲﾁｸﾞﾝﾆｷﾁｮｳ","210､254､267､372､444､469ﾊﾞﾝﾁ)","北海道","余市郡仁木町","２１０、２５４、２６７、３７２、４４４、４６９番地）",1,0,1,0,0,0},

    q{02405,"033  ","0330071","ｱｵﾓﾘｹﾝ","ｶﾐｷﾀｸﾞﾝﾛｸﾉﾍﾏﾁ","ｲﾇｵﾄｾ(ｳﾁｶﾅﾔ､ｳﾁﾔﾏ､ｵｶﾇﾏ､ｶﾅｻﾞﾜ､ｶﾅﾔ､ｶﾐｻﾋﾞｼﾛ､ｷｺｼ､ｺﾞﾝｹﾞﾝｻﾜ､","青森県","上北郡六戸町","犬落瀬（内金矢、内山、岡沼、金沢、金矢、上淋代、木越、権現沢、",1,1,0,0,0,0},
    q{02405,"033  ","0330071","ｱｵﾓﾘｹﾝ","ｶﾐｷﾀｸﾞﾝﾛｸﾉﾍﾏﾁ","ｼｷ､ｼﾁﾋｬｸ､ｼﾓｸﾎﾞ<174ｦﾉｿﾞｸ>､ｼﾓｻﾋﾞｼﾛ､ﾀｶﾓﾘ､ﾂﾞﾒｷ､ﾂﾎﾞｹｻﾞﾜ<2","青森県","上北郡六戸町","四木、七百、下久保「１７４を除く」、下淋代、高森、通目木、坪毛沢「２",1,1,0,0,0,0},
    q{02405,"033  ","0330071","ｱｵﾓﾘｹﾝ","ｶﾐｷﾀｸﾞﾝﾛｸﾉﾍﾏﾁ","5､637､641､643､647ｦﾉｿﾞｸ>､ﾅｶﾔｼｷ､ﾇﾏｸﾎﾞ､ﾈｺﾊｼ､ﾎﾘｷﾘ","青森県","上北郡六戸町","５、６３７、６４１、６４３、６４７を除く」、中屋敷、沼久保、根古橋、堀切",1,1,0,0,0,0},
    q{02405,"033  ","0330071","ｱｵﾓﾘｹﾝ","ｶﾐｷﾀｸﾞﾝﾛｸﾉﾍﾏﾁ","ｻﾜ､ﾐﾅﾐﾀｲ､ﾔﾅｷﾞｻﾜ､ｵｵﾏｶﾞﾘ)","青森県","上北郡六戸町","沢、南平、柳沢、大曲）",1,1,0,0,0,0},

    q{03302,"02851","0285102","ｲﾜﾃｹﾝ","ｲﾜﾃｸﾞﾝｸｽﾞﾏｷﾏﾁ","ｸｽﾞﾏｷ(ﾀﾞｲ40ﾁﾜﾘ<57ﾊﾞﾝﾁ125､176ｦﾉｿﾞｸ>-ﾀﾞｲ45","岩手県","岩手郡葛巻町","葛巻（第４０地割「５７番地１２５、１７６を除く」〜第４５",1,1,0,0,0,0},
    q{03302,"02851","0285102","ｲﾜﾃｹﾝ","ｲﾜﾃｸﾞﾝｸｽﾞﾏｷﾏﾁ","ﾁﾜﾘ)","岩手県","岩手郡葛巻町","地割）",1,1,0,0,0,0}
    ;

run '毛萱', 'ケガヤ', '4', ['前川原232〜244', '311', '312', '337〜862番地〔東京電力福島第二原子力発電所構内〕'], ['マエカワハラ232-244', '311', '312', '337-862バンチトウキョウデンリョクフクシマダイ2ゲンシリョクハツデンショコウナイ'];
run '大江', 'オオエ', '7', ['1丁目', '2丁目「651、662、668番地」以外', '3丁目5', '13-4', '20', '678', '687番地'], ['1チョウメ', '2チョウメ<651,662,668バンチ>イガイ', '3チョウメ5', '13-4', '20', '678', '687バンチ'];
run '大江', 'オオエ', '11', ['2丁目651', '662', '668番地', '3丁目103', '118', '210', '254', '267', '372', '444', '469番地'], ['2チョウメ651', '662', '668バンチ', '3チョウメ103', '118', '210', '254', '267', '372', '444', '469バンチ'];

do {
    my @args = @_;
    my $row = $parser->fetch_obj;
    is($row->town, '犬落瀬');
    is($row->town_kana, 'イヌオトセ');
    is(scalar(@{ $row->subtown }), 22);
    is($row->subtown->[0], '内金矢');
    is($row->subtown_kana->[0], 'ウチカナヤ');
    is($row->subtown->[10], '下久保「174を除く」');
    is($row->subtown_kana->[10], 'シモクボ<174ヲノゾク>');
    is($row->subtown->[14], '坪毛沢「25、637、641、643、647を除く」');
    is($row->subtown_kana->[14], 'ツボケザワ<25,637,641,643,647ヲノゾク>');
    is($row->subtown->[18], '堀切沢');
    is($row->subtown_kana->[18], 'ホリキリサワ');
    is($row->subtown->[21], '大曲');
    is($row->subtown_kana->[21], 'オオマガリ');
};

run '葛巻', 'クズマキ', '1', ['第40地割「57番地125、176を除く」〜第45地割'], ['ダイ40チワリ<57バンチ125,176ヲノゾク>-ダイ45チワリ'];



sub run {
    my @args = @_;
    my $row = $parser->fetch_obj;
    is($row->town, $args[0]);
    is($row->town_kana, $args[1]);
    if ($args[2]) {
        is(scalar(@{ $row->subtown }), $args[2]);
        for my $i (0..($args[2] - 1)){
            is($row->subtown->[$i], $args[3]->[$i]);
            is($row->subtown_kana->[$i], $args[4]->[$i]);
        }
    } else {
        is($row->subtown, undef);
    }
};

done_testing;
