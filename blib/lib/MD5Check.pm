package MD5Check;

use strict;
use warnings;
use utf8;
use Digest::MD5;
require Exporter;

our @ISA     = qw(Exporter);
our @EXPORT  = qw(md5init md5check);

=head1 NAME

MD5Check -  Use it for init Web files's md5 values of your site(or other dir), and check if it changed!

检查web目录（或者其他重要系统目录）md5值，当目录文件变化提醒。用于文件防篡改。

=head1 VERSION

Version 0.06

=cut

our $VERSION = '0.06';


=head1 SYNOPSIS

    use MD5Check;

## 初始化目录md5值,参数为要监控的目录

    my $mydir=shift;
    print md5init($mydir);

## 对目录文件进行检查，只需输入之前保存的md5 文件值。

    use MD5Check;
    my $mydir=shift;
    print md5check($mydir);

    # oneliner，perl单行程序实现功能。

需要安装该模块，简单通过 cpanm MD5Check 安装。

    $ perl -MMD5Check -e 'print md5init("/web")' >file
    $ perl -MMD5Check -e 'print md5check(file) perl -MMD5Check -e 'md5check(file)'..


=cut
my $DEBUG=0;
sub md5_sum {

 my ($file_name,$mode)=@_;
 my ($FD,$ctx, $md5);
   open ($FD,$file_name) or die "Can't open /'$file_name/': $!";
     $ctx = Digest::MD5->new;
       binmode($FD) if $mode;
     $ctx->addfile($FD) || die "$!\n";
    $md5 = $ctx->hexdigest;
   close $FD;
 return $md5;
}

sub md5check {
my $file=shift;
open(my $fd, '<',$file) or die "$file: $!\n";
my $res.=$file."\n";
while (<$fd>){
        my ($name, $sum) = split /\s+/;
        $name =~ s/^\*//;
        if ($sum eq md5_sum($name,1)){
                $res.= "$name OK\n";
        }
        else{
          $res.= "$name FAILED\n";
        }
}

close $fd;

return $res;
}
# 遍历目录计算md5值
sub md5init {

    my $fd=shift;
    my $md5value;
    my $res;
    if ( -f $fd ){
            if ( -T $fd ) {
                #print "按照文本模式进行计算MD5!\n";
                $md5value =md5_sum($fd,0);
                $res.= "$fd\t$md5value\n";
            }elsif( -B $fd ){
                #print "二进制文件用binmod计算MD5!\n";
                $md5value =md5_sum($fd,1);
                $res.= "$fd\t$md5value\n";
            }else{
                #print "其他文件，按照bimmod计算!\n";
                $md5value = md5_sum($fd,1);
                $res.= "$fd\t$md5value\n";
            }
     }
     elsif( -d $fd ){
        my $file_md5;
      print "开始验证目录下所有文件:\n";
       opendir (my $DH,$fd) or die "Can't open dir $fd: $!";
         for(readdir $DH ){
         my $file=$fd.'/'.$_;
      # 上级目录..，本目录. 以及连接文件跳过
         next if ($file =~ m{/.$} || $file =~ m{/..$} || -l $file );
         $res.=md5init($file);
          print "Debug::",$res if $DEBUG;
        }
       closedir $DH;
    }
return $res;
}

1;
__END__

=head1 DESCRIPTION

MD5Check - Use it for init Web files's md5 values of your site(or other dir), and check if it changed.

MD5Check is not standardized. This module is far from complete.


=head2 IMPLEMENTATION

#Init the web dir md5 values

    use MD5Check;
    my $mydir=shift;
    print  md5init($mydir);
=====================
#check files 

    use MD5Check;
    my $mydir=shift;
    print md5check($mydir);

=head1 Git repo

L<https://github.com/bollwarm/MD5Check.git>

=head1 AUTHOR

orange C<< <linzhe@ijz.me> >>, L<http://ijz.me>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2016 linzhe

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.


=cut


=head1 AUTHOR

orange, C<< <linzhe at ijz.me> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-md5check at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=MD5Check>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.




=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc MD5Check


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker (report bugs here)

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=MD5Check>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/MD5Check>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/MD5Check>

=item * Search CPAN

L<http://search.cpan.org/dist/MD5Check/>

=back


=head1 ACKNOWLEDGEMENTS


1; # End of MD5Check
