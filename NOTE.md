# UTIL

## 雪花算法

项目使用的雪花算法作者：Polim

名称：IdWorker.java

描述：分布式自增长ID

Twitter的 Snowflake　JAVA实现方案

核心代码为其IdWorker这个类实现，其原理结构如下，我分别用一个0表示一位，用—分割开部分的作用：
`1||0---0000000000 0000000000 0000000000 0000000000 0 --- 00000 ---00000 ---000000000000`
在上面的字符串中，第一位为未使用（实际上也可作为long的符号位），接下来的41位为毫秒级时间， 然后5位datacenter标识位，5位机器ID（并不算标识符，实际是为线程标识），然后12位该毫秒内的当前毫秒内的计数，加起来刚好64位，为一个Long型。

好处是，整体上按照时间自增排序，并且整个分布式系统内不会产生ID碰撞（由datacenter和机器ID作区分），并且效率较高，经测试，`snowflake每秒能够产生26万ID左右`，完全满足需要。

每秒可以生成26万ID，如果超过这个数，则排队，是否使用这个算法还是要看实际场景。

`64位ID (42(毫秒)+5(机器ID)+5(业务编码)+12(重复累加))`



# IDE

## 普通Java项目转Maven

https://www.cnblogs.com/AryaZ/archive/2018/03/23/8631666.html

## Spring项目不识别yml配置文件

`ProjectStructure`->`facets`->`Customize Spring Boot(右上角的小绿叶图标)`->添加配置文件所在位置

https://www.cnblogs.com/kangkaii/p/8442822.html

# Maven

### pluginRepositories标签的作用

pom.xml中pluginRepository标签的作用是: 用来配置maven插件的远程仓库。

### GroupId不合法

您不能在groupId或artifactId中使用括号.

这些字段由以下正则表达式验证：Maven中的[[A-Za-z0-9_\\-.\]+](https://github.com/apache/maven/blob/maven-3.3.9/maven-model-builder/src/main/java/org/apache/maven/model/validation/DefaultModelValidator.java#L67).因此,你不能有括号;唯一有效的字符是字母数字,下划线,短划线和点.您可以将项目重命名为：

# 业务处理

## Controller

### Controller分页参数使用基础类型

因为基础类型有初始值，如果前端没有传入参数，JVM会给他一个基础值

# 数据库

## 注意Null值的处理

在数据库中对列值做算数操作时要注意null值，对null值做算术操作还是null值

# SpringBoot-jpa-repository

注：JPA的底层还是使用了Hibernate，但是可以使用原生SQL(native support)

```java
public interface LabelDao extends JpaRepository<Label, String>, JpaSpecificationExecutor<Label> {}
```

使用`JpaRepository`做普通增删改查，用`JpaSpecificationExector`做复杂的条件查询

### 带条件的复杂查询1

这是一个specification的一个匿名内部类，重写了toPredicate方法

```java
private Specification<Label> searchMap(Label label) {
    return (Specification<Label>) (root, query, cb) -> { // 这是一个specification的一个匿名内部类，重写了toPredicate方法
        List<Predicate> list = new LinkedList<>();
        if (!StringUtils.isEmpty(label.getLabelname())) {
            Predicate labelname = cb.like(root.get("labelname").as(String.class), "%" + label.getLabelname() + "%"); // 相当于where labelname=? 
            list.add(labelname);
        }
        if (!StringUtils.isEmpty(label.getState())) {
            Predicate state = cb.like(root.get("state").as(String.class), label.getState()); // 相当于where state=?
            list.add(state);
        }
        Predicate[] array = new Predicate[list.size()];
        array = list.toArray(array);
        return cb.and(array);
    };
}
```

Root<Label> root：根对象，也就是要把条件封装到哪个对象中。相当于 where条件语句

CriteriaQuery<?> criteriaQuery：封装查询关键字，比如group by order by等

CriteriaBuilder cb：用来封装条件对象，如果直接返回null，表示不需要任何条件

### 带条件的复杂查询2

除了上面的方式指定查询条件外，可以使用以下方法进行带条件的查询

```java
List<Enterprise> findByIshot(String ishot);	// 相当于where ishost = ?
List<Recruit> findTop6ByStateNotOrderByCreatetimeDesc(String state); //相当于where state not in (?) order by createtime desc limit 0 6;
```

### 带条件的复杂查询(多表查询)3-native sql

遇到多表查询的情况时，可以自己写SQL进行查询

```java
@Query(value = "SELECT * FROM tb_problem, tb_pl WHERE id = problemid AND labelid = ? ORDER BY replytime DESC", nativeQuery = true)
List<Problem> newList(String labelId, Pageable pageable);	// 传入pageable即可进行分页
```

### 分页查询

`findAll()`方法接受一个Pageable，用于分页

```java
Pageable pageable = PageRequest.of(currentPage - 1, pageSize); // 页数从零开始
labelDao.findAll(new Specification(...), pageable);
```

### 使用JPA+原生SQL进行增删改操作

需要使用`@Modifying`注解配合`@Query`注解进行开发，`@Query`注解的地方写SQL，`@Modifying`注解表示可能会进行增删改操作，使用`@Modifying`注解甚至可以使用DDL语句

> **The [@Modifying annotation](https://docs.spring.io/spring-data/jpa/docs/current/api/org/springframework/data/jpa/repository/Modifying.html) is used to enhance the *@Query* annotation to execute not only *SELECT* queries but also *INSERT*, *UPDATE*, *DELETE*, and even *DDL* queries.**

## Mybatis 和 JPA的区别

多表查询下的区别





# Exception

## Spring boot configuration annotation processor not found in classpath

https://blog.csdn.net/qinxian20120/article/details/80252894

classpath中找不到SpringBoot注解配置，根据IDEA的提示会跳转到一个页面，里面有一个Maven依赖，貌似需要添加这个依赖到项目中，但是我没有试过。

> 根据提示信息….not found in classpath，查询此注解的使用关于怎么指定classpath，进而查询location，Spring Boot1.5以上版本@ConfigurationProperties取消location注解，反正就是在1.5版本后改变了@ConfigurationProperties注解的使用，我用的是2.0.1版本，自然会有这个问题。最后还是附上连接中描述的截图，有兴趣的可以进去看下。

## SpringBoot

## JPA

### Executing an update/delete query

https://blog.csdn.net/moshowgame/article/details/80090453

SpringBoot2+JPA进行增删改操作时需要`@Modifying`和事务支持，解决的办法：在Repository的方法上加`@Modifying`注解，在Service上加`@Transactional`注解

## Mysql

### The server time zone value 'ÖÐ¹ú±ê×¼Ê±¼ä' is unrecognized or represents more than one time zone

时区问题，可以在url上指定时区或者改变数据库的配置

```
jdbc:mysql://127.0.0.1:3306/sdcommunity_base?useUnicode=true&characterEncoding=utf8&useSSL=false&serverTimezone=Asia/Shanghai&rewriteBatchedStatements=true
```

