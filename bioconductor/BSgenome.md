# BSgenome

## 简介

Bioconductor 提供了部分物种的全基因组序列数据包，这些数据都是基于 Biostrings 构建的，称为 BSgenome 数据包。

不同物种的 BSgenome 数据包都有类似的数据结构，可以用统一的方式进行处理。但是 BSgenome 数据包只包含数据，它们的处理方法由另一个软件包提供，即 BSgenome 包。

BSgenome 用于高效存储全基因组及其单核苷酸多态（SNP）的包，截止目前（2023-03-22），BSgenome 包含人类基因组在内的 113 个物种的全基因组数据。数据的命名一般由 4 部分构成：

- BSgenome.organism.provider.provider_version

## 演示

```r
> library(BSgenome)
> available.genomes()
  [1] "BSgenome.Alyrata.JGI.v1"                           
  [2] "BSgenome.Amellifera.BeeBase.assembly4"             
  [3] "BSgenome.Amellifera.NCBI.AmelHAv3.1"               
  [4] "BSgenome.Amellifera.UCSC.apiMel2"                  
  [5] "BSgenome.Amellifera.UCSC.apiMel2.masked"           
...                            
[109] "BSgenome.Tguttata.UCSC.taeGut1.masked"             
[110] "BSgenome.Tguttata.UCSC.taeGut2"                    
[111] "BSgenome.Vvinifera.URGI.IGGP12Xv0"                 
[112] "BSgenome.Vvinifera.URGI.IGGP12Xv2"                 
[113] "BSgenome.Vvinifera.URGI.IGGP8X"                    

# 统计数据库中的物种频率
> table(available.genomes(splitNameParts = T)$organism)

                 Alyrata               Amellifera             Aofficinalis 
                       1                        4                        1 
               Athaliana                  Btaurus               Carietinum 
                       2                        9                        1 
                Celegans              Cfamiliaris                 Cjacchus 
                       4                        4                        2 
CneoformansVarGrubiiKN99             Creinhardtii            Dmelanogaster 
                       1                        1                        5 
                  Drerio                 Dvirilis                    Ecoli 
                       8                        1                        1 
              Gaculeatus                  Ggallus                     Gmax 
                       2                        6                        1 
                Hsapiens               Mdomestica            Mfascicularis 
                      14                        1                        2 
                   Mfuro                 Mmulatta                Mmusculus 
                       1                        6                        7 
                 Osativa                Ppaniscus             Ptroglodytes 
                       1                        2                        6 
             Rnorvegicus              Scerevisiae                  Sscrofa 
                       6                        3                        3 
                 Tgondii                 Tguttata                Vvinifera 
                       1                        3                        3 

# 下载所需基因组数据
> BiocManager::install("BSgenome.Hsapiens.UCSC.hg19")

# 上面如果下载失败，可以先手动下载下来，然后通过源码安装
> install.packages("C:\\Users\\happy\\Downloads\\Compressed\\BSgenome.Hsapiens.UCSC.hg19_1.4.3.tar.gz", repos = NULL, type = "source")

# 查看已安装的基因组数据
> installed.genomes()
[1] "BSgenome.Hsapiens.UCSC.hg19"
> library(BSgenome.Hsapiens.UCSC.hg19)

# 查看序列名称
> seqnames(Hsapiens)
  [1] "chr1"                  "chr2"                  "chr3"                 
  [4] "chr4"                  "chr5"                  "chr6"                 
  [7] "chr7"                  "chr8"                  "chr9"                 
 [10] "chr10"                 "chr11"                 "chr12"                
 [13] "chr13"                 "chr14"                 "chr15"                
 [16] "chr16"                 "chr17"                 "chr18"                
 [19] "chr19"                 "chr20"                 "chr21"                
 [22] "chr22"                 "chrX"                  "chrY"                 
...  
[292] "chr21_gl383578_alt"    "chr21_gl383579_alt"    "chr21_gl383580_alt"   
[295] "chr21_gl383581_alt"    "chr22_gl383582_alt"    "chr22_gl383583_alt"   
[298] "chr22_kb663609_alt"   

# 访问 1 号染色体数据
> Hsapiens$chr1
249250621-letter DNAString object
seq: NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN...NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN
# 查看各序列长度
> seqlengths(Hsapiens)
                 chr1                  chr2                  chr3 
            249250621             243199373             198022430 
                 chr4                  chr5                  chr6 
            191154276             180915260             171115067 
                 chr7                  chr8                  chr9 
            159138663             146364022             141213431 
                chr10                 chr11                 chr12 
            135534747             135006516             133851895 
...

# 查看各碱基在 1 号染色体上的频率
> alphabetFrequency(Hsapiens$chr1, baseOnly = TRUE)
       A        C        G        T    other 
65570891 47024412 47016562 65668756 23970000 
> alphabetFrequency(Hsapiens$chr1, baseOnly = TRUE, as.prob = T)
         A          C          G          T      other 
0.26307213 0.18866317 0.18863167 0.26346476 0.09616827 
> letterFrequency(Hsapiens$chr1, 'C', as.prob = T)
        C 
0.1886632 
> mm <- matchPattern("CG", Hsapiens$chr1)
> length(mm)
[1] 2284470

# maskMotif 将 22 号染色体上的 N 进行遮盖，便于后续分析
> chr22NoN <- maskMotif(Hsapiens$chr22, "N")
# 统所有碱基出现次数
> alphabetFrequency(chr22NoN)
      A       C       G       T       M       R       W       S       Y       K 
9094775 8375984 8369235 9054551       0       0       0       0       0       0 
      V       H       D       B       N       -       +       . 
      0       0       0       0       0       0       0       0 
> GC_content <- letterFrequency(chr22NoN, letters = "GC")
> GC_content
     G|C 
16745219 
> GC_percentage <- letterFrequency(chr22NoN, letters = "CG", as.prob = T)
> GC_percentage
      C|G 
0.4798807 
```
