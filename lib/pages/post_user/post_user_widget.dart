import '/backend/backend.dart';
import '/components/comment_card/comment_card_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'post_user_model.dart';
export 'post_user_model.dart';

class PostUserWidget extends StatefulWidget {
  const PostUserWidget({
    super.key,
    required this.postRef,
  });

  final DocumentReference? postRef;

  static String routeName = 'PostUser';
  static String routePath = '/postUser';

  @override
  State<PostUserWidget> createState() => _PostUserWidgetState();
}

class _PostUserWidgetState extends State<PostUserWidget> {
  late PostUserModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PostUserModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
        automaticallyImplyLeading: false,
        leading: InkWell(
          splashColor: Colors.transparent,
          focusColor: Colors.transparent,
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () async {
            context.pop();
          },
          child: Icon(
            Icons.chevron_left_rounded,
            color: FlutterFlowTheme.of(context).primaryText,
            size: 32.0,
          ),
        ),
        actions: [],
        centerTitle: false,
        elevation: 0.0,
      ),
      body: StreamBuilder<PostsRecord>(
        stream: PostsRecord.getDocument(widget!.postRef!),
        builder: (context, snapshot) {
          // Customize what your widget looks like when it's loading.
          if (!snapshot.hasData) {
            return Center(
              child: SizedBox(
                width: 50.0,
                height: 50.0,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    FlutterFlowTheme.of(context).primary,
                  ),
                ),
              ),
            );
          }

          final columnMainContentPostsRecord = snapshot.data!;

          return SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Container(
                    width: MediaQuery.sizeOf(context).width * 1.0,
                    height: 360.0,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                    ),
                    child: Builder(
                      builder: (context) {
                        final imagesPath =
                            columnMainContentPostsRecord.image.toList();

                        return SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(imagesPath.length,
                                (imagesPathIndex) {
                              final imagesPathItem =
                                  imagesPath[imagesPathIndex];
                              return Padding(
                                padding: EdgeInsets.all(16.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12.0),
                                  child: Image.network(
                                    valueOrDefault<String>(
                                      imagesPathItem,
                                      'data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAkGBxMTEhUSEhIVFRUVFxUWFxUXFRUVHRUfFRUYFhUXFxUYHSggGB8lJxUWIjEhJSkrLi4wFx8zODMtOCgtLisBCgoKDg0OGhAQGC0dHx0rLS0tLS8rLS0vLS4tKy03LS0tLTgtLTEtLi0vLS0tLSstLS0tLTctLS0tLS03LS0tLf/AABEIAOEA4QMBIgACEQEDEQH/xAAcAAABBQEBAQAAAAAAAAAAAAADAAIEBQYBBwj/xABEEAABBAADBQUEBwYEBQUAAAABAAIDEQQSIQUGMUFREyJhcYEykaGxBxQjQlJywTNigpKy8CQ00fFTc7PS4RVjdIOT/8QAGwEAAwEBAQEBAAAAAAAAAAAAAQIDAAQFBgf/xAApEQACAgEDAwMEAwEAAAAAAAAAAQIRAxIhMQRBURMycQUiM2EGQsEV/9oADAMBAAIRAxEAPwDy5r0dgUeJqnRMRSChuRDfGpzY0nwp9JrK7KixhFdCnsiSNDJnI2I31dHhiU6PDplEDZSyYZQ5sOtLJhlBmw6eibM1NFSAryXAudoBx9PDin4bBxx25/ePgaDdfekkFIpImE8BfAe/gp0WzpSLy+hIHqpUeN1Ia4VTrIaAeFmvBNk2m4iyWnjWgvhQsf68ULDQjsyQctBz4D0J4pgw7unxHmlHinG3WQSNC1wbWvAt18NNF366QMoDfE1rd9UDUcLSOITDKjsxfe4kiqq9PTklOyJ/sd116akg+F0mUgNEUyoL3JSxFujhSESqqYp211DtOBQc2MkOKauppKRysYRTmJlp7SkASWJxQgU7MhQ9iSXElgEjDtVlBGoGHVthk0QNUGjhRDCixooaqoBXPgXGwqxMK6IVqNZHhiVhFGmMjR2BFIDOSR6KuxMdC+QVsVjdvbQBfQJGXTLy06/30Qm6MkD2ljnXljAAB9oFpJ93Diql2JdVFxTC8XdfEj4okGFlkPcjLvRRbGSsGZb4151qui7sH1VjFu/iHURCQFYRbpzmjQHhd/JJrj5GWOXgzwdrfA9V3O4a3fu+S0M+68zASWWK5f6Kndhi06g+I5j0RUk+DODXIDtLXA/ojS4ct1HAoXZa8EwrQZk+cEO1PI9FEdoURzCEsS3WxzRTAwa6Cm0laLAPJTSU0uTVqNY8FFahNCOwLAHtTqSYn0gEZSSfSSwSTCVY4dyrIlPw5QiUZawlTYwq+AqdE5WRJkgMSyJNcnWnAcDUrSJQnvQMOnkppPgVVYTdqJ8lSyRsAFl0jnNa5w1LQWiwOIs0NFLxBtpF1YOqnGKeJuYYGOZpABe9rZnDn7Afmj/lB8VHKyuNEcbJwrDccbKvm4P9bv5DwUqMM5C/Bo0Q4J2udQgZA7oWE3VAkE/p8eKkTg/elPk1tX5Lz5vc74JUScK0a5mub7j79dFKhYSefPkL6+9RsLHKBQhlo8yav0OqssBg5HWeydQqzqQPM6a9PJBKwt0F2jsx3ZFxFtAuw4dNe8Cc1eF8/ErAYpgMri+i2zwGpH73u4WvRse1jS5jWurgRmLBYoGnen+yzWL2GLzZsp00Gtj16eHJWtRItSZjsXCzgxtNvibPv6UmMwHCqvQWOdkD9R71pjs4DhysfAeCczZ4111JvzIN3p6e5FTRNwMZtGHmBQrl8/eq5w7oWx21gAI3Vwr5arHV3fUq0JWQmqYEpjk8oblUQanBMTmlawBmIzQgtKM0pTDwnhDBTwVgjqSXLSWNZPjjUmNlJsI0RgUUhtQeJylRvUBrkQSKiFbLNkiKHKuilUprkwAznqPK9Pc5RJnLGOdvRurrWvIX+iju2/cod3WkULYxrBp1DABfU8+a7hTcgHW/6TSj7QkjY6hlPXgubK96ZbHa4NZhJRKGm7rmpOMlMbS5ot3ID/VZrZO0xoBor8T2LOq4XGmdcZ2ioZjsdITkAZXhV+pV5sfG4pp+0jPm0i+HDjp5qh2htmrNmkfZm2pQMwfAAPxyOadeHey5dfNU+EKq7s3YxjJK4td+F4rNfK9OGvn8VExY8OZ1/vT3KJHtJzqbLGWE8LIcD4tcLBUvNyClORaKRWyxa2k1ikzNQmhKmCSKnbTLY4DiRXv0WB+r6EdCQvXmbMa1xdIM9eyzTvEcPBZHbMLZHSnsGwyMLc7WkEODtA7QAEi26+KvjyadjnzYnpcl2MDNHSjPKvMbhlTTspdSlZxqVgbTgUNdaUwSQ1yIHqMCntKwrYfOnCRABXQVhbD511AzLqxrL9jkQOUJsqKJU4bJTXJ2dQ3TLsctpgWWEZUyN6r43KQx6IyJbiomIci9ooeJesEjifI8O/CQfdxC5srBvfiJInODaDrOVhJpwFW5p01UPFv0PkfkttvLhQwM7N7mkgucASBZAF+a58j7lcaszjtmOjna1lOGdrSBpYcRy5ceWngF6tgdkxGPK4a8L5GrBWG3Z2a7tWGiaIeeoa0gk+HIeoXqOyy3KGOGvX+/Vcs3bOuCpHlO+u6/Z95rjlvUVw101vhx1V9uztqJsLYXNz0xrSKBum1rfFbPa2zWkZXgODgTpf3eOtf3SzA2K6J1xlrm3zFH3c0dUkjaYyYbBbuwlpyDswTYa0uyjTk28rfQKedlGNos38UXA4wjRwrwRNo43MBwACnJxatlEmilxTUHCC3ihda0jzm13ZVB9lRHZDxm2JYpP2GZpBBe5pIBBIoEaD1TNsPEkZmy057Mh9HA/r8FqoGtqR7Nc4cSDqG2dT5njXis7vCW5WsaCBqdeJ5Zq5Dp5FPFcEs81DFJ/owWOgWdx8S2ONjWb2jGumDPExyM6Ugnyt1XGtXQdJ0J4SaxPyIgbOBK0iEgFhTq6uUurAJbCjxlBaisKcAQhPjTMy7mRMTGSIrZVXdouiVax0WnaqJPKg9uo8sy1jDMQ69FuZcR2oilP3o43V0JYL+Nj0Xn0j1r93cRnwrRzje5noTnb6d4j+BQyq0VxOpGp2PtWGHuFwzPy5zp3aJIj+TuWpHQFXG1t58LA0OfNluqaBbj5NGvqvMNr7OJk7QaXV1z5BXuwo8I77PEwxve6qf2QPvI1vxXO4p7s6ozfBuYtpMmY2aGTOCLvw56cLGqG+W9aTdhbGbETlc3LyDWho1HQEos8dEhRlsWVAB5p5emvQJZqCRjWLEFDjky6phdmNpkruSFC2WEm3IiwOjmz6eyAK+CocZiC9xc7if04Lk2GZDCGsFDMPH4qF2ivFbHl9fkk2odgOKas/tCPir2d6qMYqR5OGHJlcUzVDY1WOKjUdka6kdi4ORtRQxFZGiCNE1EN7EPKpro0NzEDUR6XEfIuoAOsKIFHa9ED06YoQlczJuZczLWYcXLhemErhKFlEh5kQnvTXuQi5CwnSVc7r4rJIWHhKA3+JtmP5ub/GFSBFjcQQRoRqD0I4EIPcydG32htRseRtNNanMLu9B46UnYfbmHHeAa0nX2M1de8dVn8fCcQY3tLW5294m6BBpwFDrdDyVjDuNGGZ3YrNfJgDf6rPwUHFdzrxuT4RrtlbwR8GyBp5WbafX2h62rzB48TXYpw4i7WU2fuzs+NvedI49M7hr6EfJW2ycLHH+xBDbvvOJJ63Z+CjNKti9NFvNGVBlZZU+WWwocj1GxgJbQUKabvABLHYytEDZ4t1lMl3Fb3ofvE6o2/mHyKpWS6K13sf8AZsH736FZntaXRijcTzurjeQmTSqrxT0SSdQZ5VZQOaMCHiHILHJTPQgVVF0iwjKKoEcikskQGCEIMgRLTXBYzQGkkTIkiKVwKcHJgXQgIFDk9pQQiNKwYhE0rqa5AoCeUElGerLY+7GIxLTIxrWR6/ayEtaa5MABc8/lBHWkQNpclS1aXdXc3FY532LWtZqTLI7K2gcpqgXO100FWCLFFXGD3Vw8LM0tyyVdvtkbTx/Zii/1dr05JDed+HmD4n5i2hQaA3Lp3K4AeQFckaI+sm9ty33r3JZgMHEWSulf2h7V1ZR32gDI37rRkA6nNr4efPlmvK1zvIL0fbu8IxuG7RooDuyRk2WO4gnqDWh8vGsdBimgEGlPIq4OqDvuSNi7OxDiHyE1yBP6BbOBhaznwWY2dtkNHH0UzFbyjJQIs8/0XJKLbOuMopclxg8ZYcCRpw93RRsZjwNAsxDtIukeW3R8dByXH43Xij6e4nqFmH5jZV7s+A6Ku2Hg83ecFooXdBoklsPBdyg3piOVp1oOomjQLgcoJAoXldV1wKy0oXsW7mGhn+s4WUWJY2ac6a5wzDoQXNIPIgLy/bWzXYed+Hk9phIuqDtLa4fmBB94XZhitCPP6qTjksoJnqHLIrHEYYnh7lUzirBVaFjJPgjySIfaLj0NAckskUhkirwVIiKwUTmPRAgxBHaEAipcT8qSICnanBNanrE2dCcCmhS9nbPfM7KwDxcTQb4k+73hYW6BBWGxthz4p1QMzAGnPPdYz8z+vgLPgrzZ+78MfflubLrlceyYegygOc/ysDqFf47a7DGI+1fE0CskMeRoHQPadB/L5IqHkWWdcRIcGy8DgRczhPP+UOyH9yLUN/M/XpXBVu1N6J3k9nUbeH4nkeLzw/hr1ULEMg+45/qB71FdH6piLdu5bkLETPcbe4uPiSU7DkXqLCM6IFR5IqQHsLK8s7zCRYo+I6HqPAqC6fPfJ/TkfJTY5xVEWqvFx0bCVopjlWxJbHLVgGkNsp5o+y8aQ4B3Drx969M2X9H0eJa2V4OQgEOY4W4dWngfigoltR5vh3SO7jRp0GnqT/5U7BsyHVmvj+i9Cxf0dOjH+HPat/CaZIPMHuv9CPJUEuy3NcWuBBHFrgWkeYOoUZ2uUXik+Cbs/H5mgAK8w76FqkwOEpW7WUFyy5OqPA/YeJdHtPCSfdm7fDu/iYHsP80fxVh9NOxLZFjGjVjhE8joTmicfI23/wCxRNn4B0mLwTAD3ZhMT0bEMzifgP4gvRd68AJ8DiIyOMTyPzMGZh9C0LtwP7Ti6iKbZ88SNpRsRC1+jh6jQj1UomwD1AQqXQeWnXBnsfs5zNR3m/iA4fmHL5KvpbEFQcbslj9Y6Y7pwa7/ALT8PLilaOmGbtIz7Wo8YXTEWktIojQg8k8BCi4eMqQ1RGFSY3LNBTC0uptrqASnaE4BcCc1YnImbL2c+eQRs4nUk8GgcXE8gFvmYeHDsEUYsDUuPF5/EfDoOAvrqg7lbJIaxgvtMQWl1VbGchqRwFurmTSvN/d3PqrmSRuL4ZNASQSxwF5SRxBFkHwPRUSOSdy44Rm8XPm0HBBYEfC4HNE6aSaOJtOyB5OaYt0IijbZIvTNwB8ioAxCJPS0NxOC+83hzHRAMJCM2Yg+CsYI2vHmga2VIY08W+oKTsCD7JtTsTga1afQqJmrjosGyBPs4jWkH6nm0Ku48T+LUJS4dp4GkKDrZVQYXszbfetJuvvViMG77Mh0ZNuhfeR18S3nG7xHqCqh0Dm+ITmi+K1B1vk9w3d3nwmOprT2U3/CfQJ/I7g8eWvUBXeM2OyVuWZjZAOBI1b+Vw1Hovn2OtPCiPAjUEL0XdP6QHxZYsWTIzgJtS9vTOPvjx9rzWa2L48y7lrtHcYt72HeT/7b6B9HcD615qm+ova7I5pDr9kg34aL1HC4lkrBJG5r2O1DmkEHyITnRDQ0CRwJFkXxo8lzSwxf6O2OZpb7lLu7sXsQZHgdq4ZfyN45fMnU+Q6KbvBihFhZ5D92J58zlND1NBTwV5t9Ku8QIGCjN0Q+YjlWrI/O6celN6q0Y9kQyTpOTPLnMoAdAgEqZIVFkaqs89HAF1sa40o7VglZtvD6B/MaH9FThaTHsthHu+Q+YWbCVnThf20OCMwoNrrSsXJWdcQMySFGsiBWWw8GJJO/7DBmd466N9fkCooiV1hojDGWuFPdTiDoQMtsB6aG6/eSRdsXMnGJPx+MzE3rfktX9Gu33Ol+pYktkwnYyFsUjGvDTHTwG2LIyh/d1qhVLz101qbsbaZw80c7WhzoySA7hZa5outdM1+ioc0PtY6fHPmd2jzbnAcAGhoA7rWtbo1oHADRIBQodAAOQA9yttksjOaSbWKINJYHZXSudfZxNPFt5XEu5NY7nSIrVsEzLepHvUlkf4XacRrz8D/fJes7m4jD7RwLxiMJAGQSFuRrO7TWh7S0HUGnUdda8aWE+kvd+PZ08MkAIw+IzWyyRG9lHuEm6IdYH7p5cBYXidWmUPauog98fEeiQc1wI/3HkiFoNHwtrh0PzTBECaPH8Q9+o9D70SRHxGBLeHmgAkKyLHN0OreNoMsQPBagkcYgpZrTHRpzWLGCMKOyRADSnAogL7dzeWfBvLonW0nvxO9l/j+6794et8F63uvvjh8b3Wns5asxPIvTiWHg8eWvUBeI7OgEkrGHgT3q400ZnV6ArdwbksD/ALzS3K5rw94IOt1VEEaa/vKWScY8nTh1vjgu9+N9xBmw+GozcHv0IhscB+J/hwHE9D5O4kkkkkk2STZJOpJJ4kraybswsF5S54GYgvfRJonvl1usl2uhOR/Cl3eDdyPIHQspwaS4NoatF0WjTXhY1uuItCOaHC7myY5y3MK9qZCwFwDjTb1KO5TNkbGkxLy2OgGjM97jTWDq4+h08FZohH3Laysx2E7N5bd87HO0xq1Mm6cJbbcaDWmc4eURX07Wy0eeqodqbNlw7wyVtEjM1wOZrx+Jjho4fHqAhFOtx8lOTcVSITz3Semvu1/RZmRlEjoSPdotOw8R5/FZ3GDvu8z81mPg5YFdXEkDpOrqZaSxqLZuHH3uHPy5o28WP7WeWT/iSSPA6BzyW/Ch6Ke6MsBfQOWjrw4gC/CyPes1I69evDyGihgdplvqEdMoocx6OTSBA3mnvKseez0H6INhQ4rESunYJGwsYQxwtpdI5wBc0+1QY7Q6a+AWtxu6mz4sLjcbLBwdiSxrS5ojETnRMbG1pAGZzM38YHAUs59B2MDMVNETRmiaW+JhcTXnUhP8JWu+krDvbsbENANh4ca/CMWHl3lWp9VisEtI/cHB9hsh0lU6cPlA652iOKvPK0j8yrPp7jH1PDtvvNlLh5MjLXf1D4Lz7C7x4pmGwzTiX5GvDoYKbQbAQWSE8S3OKa11g9m46ZQo++e8WIxpEk7gcoLWhoytbepoa6mhZvkFq3sDmktJF2PjLYAeXDy5jy5+isOJtvp6f7rL7Lny+htEn2q9riATQsX1Rsi4b7GsbiTXeb68kAe10tVGC3hcNOI5WrrC4oPGYjXjXoTp6n4I2I4tEvZ2zWSzRslk7ONzgHv0GUczZ0HSzwtbLaX0WnLnwmIEg4hkgAzdKlbp7x6rJYWQtc0g0QWuY7TQggtPTiB8uYu6bvRjc1nEyHK7MB3as3YIy94UW902BegGlZp9h4uFU0ZfF4CWJ5ikjcyThlcNddBX4h4iwp+9gi+svZBE2JkNw0OLzE5zXSP6ucb16ALZYHfuR0rPrUcDowR3mxuzMP4xbiNOdAeCyu+GzRDiXhrs7JPtY33mztlJcDm+9qSL51fNYzS07FFhcQ6NwewgEWNQ13tAtOjgRwJVk3b09VnbV3+zj43d+zxvVVpYkGLOKfKEUmuGWP8A63P+Jut39nHzzX93nmd/M7qVPdvdP2RjIYSRlzgEEA88o0vx+HG6Cl1wWcIvsH1JeR5bY0Wv2TDWEhiA0ncZJSPGduHivvAgDV2l94CxRKyUJ6rabM2c+aCHs+ytrJo80jiCwtm7Vr46BJcAeAHA6pjRR6fHh2taGAANAyhtaADSqXn+9Wwo2n6to2Ke3w+0exk0Hcod1lkZheol0rKb3uDxGdutZm014B4OoE+NEEEXrRCzn0gRl0UdNkIzPDhEQH5XRujFD7wzui05pIvc6ZpUeISEsLg4U5pIIPIg0QfIghV+8ksTpmuhrL2OGDq5vbh42yX42CD5K435eRO99UZmRzZaqjJG0vHnmD1mtrRNjmkjaSRG9zLPPI4tJ94Kam3sLiVNkYlDc9NLkgj6cvBcVpLtJI+nLwY2+8oDYgz70hAHgG95xPhQr1CybtTp5AfALTb4NPaNH7nzcc3vpvuVFhG1ch4N4eZ4e7j6BcuFVEr9SnfUSXjY5I3L3enH9UO/cEnKy2Dsx+InihjrPI8NaenMuPgACfRVOA9Y2F9FjWwxSuxE0OLFSB8eWojWjcpFuq6OuuvJWOOdtvDh1Nw+PYW0O6InjjZMdgOHVoJvlSJtLbG0MDJBHJ2eObMcjXBn1eTMKtpylzTYNjujgbqrV2d5WMH+Khmwp6yNzM//AGjLmD1IWLKuOD5y27iJziHvxQc2Vx7zXMMeUDRrWsIGVoAoD58UTGi8OT5L6B25JgcThXnEmGSANLs5c1wbQ9pjx7LuhBtfOwl/wrgeVcePHn4oslkjwytwJ4rrWguJPUoMTqamtl1SD0y4hazop8GIrhoqOKVSYpkyZJo00WKvjVeXBTIp9dfHXr7P/as1DOpsU+qZMnReTuoePL9E52PvDHDvBdlkD4nX+zzCpWUfunQ0OYUKKQEcP781wcaPL+wmNdA+a446rkjtVxxWAPtNzJAodrGDNetRuhjWd5kjHPMRGJjaxxY4ljSyQNcNeBY6uYjKyIejYTFuikZKw05hBH+hHMHUEdCVmNF0z27ERP7YCN2R5a46NGUhrhmzsvUl0oHG/s3UdSmMhL3F0kpc8ZoszG9kI7c3RurjbrB4m+6RVAqq2XvRC6NuKaDbskHEuyavIjf+EguHePtAgq2xc0rDNbbbUXY3QEhqnx2NbJY0Zjw7QdEm51WnueLfShihJjWyMIIMTHtIujmfI5po68COKwuIkL3OceLiXE9S42T8V6VtXDMxmI2lKC131bDO7IAe0YgGukaOgLZP52Lz3sl7P0zp1l1P4FToiNYiNjUlsSeIl7C+nrwbWRezSUzskk3/AD14NrNDvibmr90CvO/9VST6UwcG8T1J9o+XLyAVzvI7/EP8KA/lCpKXxGP2op1stXUTf7YMtWj3IdMzGQSQRGWRjyRGNM4LXNeL4N0c7U6DRUUTF7L9CWzGiObEEd4vELT0DWh7q8y5v8gTnPFW6JEu+TW45px+HkwrYoz2Qc3tSXSENfITGD91paMt+0+ytvszbEGIH2M0co5hrg4j8zeI9QvMsDuzidp4yTFYvtIYQ4taCCxxaxxDYmNI7oHN3MuNcbG8k3KwDmhv1ZjSB3ZGWyRviJQc1+qzotFyZi/ph3VwTMK7FsiZFOJIwCwBva5nAODmjQkDM66vu9F4zI/7KQfl/qatvv8A7PnhldDNPLOI6MbpHuf3XCwQHGgeRriWlYUj7N/kP6gtwSctT4K950AXRGnAajwSc5KUs6HKRG5BbEUZjK81hWSYnqdhyqy6UiOekyJtF/EaCTp1UMxZOiOxxTWI0THSJpkUYuXO0WsBK7VcMii5kjIjZiUHJrpNEASJPdoVrCStm7Vlw7y6J1ZhTmkZmPH4Xs4OHx8VbbQ32mdGWxxtjJBBk7SSRzQ4d7ss5+yvwWWD0na0ELGTaPQtxWxQ4PFSzBrPspIsxoF+aJ78gHP2QB1rwXnIjWs3pxBlihFkMiwuBLWiqzv7fM46ams6zFL6r+OQ+3I/gabpJA8q7SdSS+n0onY2kk9JHSjFjvH+3f5/oFUFdSX5TD2o6eq/PP5Y5nL++S9y+hX/ACMn/wAh3/SiSSTPgTF7jfuSCSSU6Dxn6Y/82f8AkRf1yrylvsP8v1SSTPscv938kB3E+nyCexcSQK9iZBzXRxSSRJg3cUZ/JJJBGC4VTYkkkyJyHSIISSRAECGUklgnW8F2X2UkkDEdqfh/aCSSATX7z/5LD/8AL2b/ANHGrJJJL7H+Ofin8/4HJycKQSSX0hM6kkksY//Z',
                                    ),
                                    width: 340.0,
                                    height: 360.0,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              );
                            }),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 12.0),
                  child: StreamBuilder<UsuariosRecord>(
                    stream: UsuariosRecord.getDocument(
                        columnMainContentPostsRecord.posterUser!),
                    builder: (context, snapshot) {
                      // Customize what your widget looks like when it's loading.
                      if (!snapshot.hasData) {
                        return Center(
                          child: SizedBox(
                            width: 50.0,
                            height: 50.0,
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                FlutterFlowTheme.of(context).primary,
                              ),
                            ),
                          ),
                        );
                      }

                      final posterUserUsuariosRecord = snapshot.data!;

                      return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  16.0, 12.0, 0.0, 12.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Container(
                                    width: 64.0,
                                    height: 64.0,
                                    decoration: BoxDecoration(
                                      color:
                                          FlutterFlowTheme.of(context).accent1,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: FlutterFlowTheme.of(context)
                                            .primary,
                                        width: 2.0,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.all(4.0),
                                      child: Container(
                                        width: 70.0,
                                        height: 70.0,
                                        clipBehavior: Clip.antiAlias,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                        ),
                                        child: Image.network(
                                          posterUserUsuariosRecord.photoUrl,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 8.0, 0.0, 0.0),
                                    child: Text(
                                      posterUserUsuariosRecord.nome,
                                      textAlign: TextAlign.center,
                                      style: FlutterFlowTheme.of(context)
                                          .bodySmall
                                          .override(
                                            font: GoogleFonts.lexendDeca(
                                              fontWeight: FontWeight.normal,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodySmall
                                                      .fontStyle,
                                            ),
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            fontSize: 14.0,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.normal,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodySmall
                                                    .fontStyle,
                                          ),
                                    ),
                                  ),
                                ].divide(SizedBox(width: 12.0)),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 8.0),
                        child: Text(
                          formatNumber(
                            columnMainContentPostsRecord.likes.length,
                            formatType: FormatType.compact,
                          ),
                          style:
                              FlutterFlowTheme.of(context).titleMedium.override(
                                    font: GoogleFonts.poppins(
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .titleMedium
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .titleMedium
                                          .fontStyle,
                                    ),
                                    color: FlutterFlowTheme.of(context).primary,
                                    letterSpacing: 0.0,
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .titleMedium
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .titleMedium
                                        .fontStyle,
                                  ),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 8.0),
                        child: Text(
                          dateTimeFormat(
                            "d/M/y",
                            columnMainContentPostsRecord.date!,
                            locale: FFLocalizations.of(context).languageCode,
                          ),
                          style:
                              FlutterFlowTheme.of(context).titleMedium.override(
                                    font: GoogleFonts.poppins(
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .titleMedium
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .titleMedium
                                          .fontStyle,
                                    ),
                                    color: FlutterFlowTheme.of(context).primary,
                                    letterSpacing: 0.0,
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .titleMedium
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .titleMedium
                                        .fontStyle,
                                  ),
                        ),
                      ),
                      Text(
                        columnMainContentPostsRecord.content,
                        textAlign: TextAlign.justify,
                        style: FlutterFlowTheme.of(context).labelLarge.override(
                              font: GoogleFonts.poppins(
                                fontWeight: FlutterFlowTheme.of(context)
                                    .labelLarge
                                    .fontWeight,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .labelLarge
                                    .fontStyle,
                              ),
                              letterSpacing: 0.0,
                              fontWeight: FlutterFlowTheme.of(context)
                                  .labelLarge
                                  .fontWeight,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .labelLarge
                                  .fontStyle,
                            ),
                      ),
                      Divider(
                        height: 32.0,
                        thickness: 1.0,
                        color: FlutterFlowTheme.of(context).alternate,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 8.0),
                        child: Text(
                          'Comentários',
                          style:
                              FlutterFlowTheme.of(context).titleMedium.override(
                                    font: GoogleFonts.poppins(
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .titleMedium
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .titleMedium
                                          .fontStyle,
                                    ),
                                    color: FlutterFlowTheme.of(context).primary,
                                    letterSpacing: 0.0,
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .titleMedium
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .titleMedium
                                        .fontStyle,
                                  ),
                        ),
                      ),
                      StreamBuilder<List<CommentsPostRecord>>(
                        stream: queryCommentsPostRecord(
                          queryBuilder: (commentsPostRecord) =>
                              commentsPostRecord.where(
                            'postRef',
                            isEqualTo: columnMainContentPostsRecord.reference,
                          ),
                        ),
                        builder: (context, snapshot) {
                          // Customize what your widget looks like when it's loading.
                          if (!snapshot.hasData) {
                            return Center(
                              child: SizedBox(
                                width: 50.0,
                                height: 50.0,
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    FlutterFlowTheme.of(context).primary,
                                  ),
                                ),
                              ),
                            );
                          }
                          List<CommentsPostRecord>
                              columnCommentsPostRecordList = snapshot.data!;

                          return SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: List.generate(
                                  columnCommentsPostRecordList.length,
                                  (columnIndex) {
                                final columnCommentsPostRecord =
                                    columnCommentsPostRecordList[columnIndex];
                                return CommentCardWidget(
                                  key: Key(
                                      'Keyuxq_${columnIndex}_of_${columnCommentsPostRecordList.length}'),
                                  commentRef:
                                      columnCommentsPostRecord.reference,
                                );
                              }).divide(SizedBox(height: 16.0)),
                            ),
                          );
                        },
                      ),
                      Divider(
                        height: 32.0,
                        thickness: 1.0,
                        color: FlutterFlowTheme.of(context).alternate,
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional(0.0, 0.0),
                  child: Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 24.0),
                    child: FFButtonWidget(
                      onPressed: () async {
                        context.pushNamed(
                          PostCommentPostWidget.routeName,
                          queryParameters: {
                            'postRef': serializeParam(
                              widget!.postRef,
                              ParamType.DocumentReference,
                            ),
                          }.withoutNulls,
                        );
                      },
                      text: 'Escrever Comentário',
                      options: FFButtonOptions(
                        width: 300.0,
                        height: 45.0,
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                        iconPadding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                        color: FlutterFlowTheme.of(context).primary,
                        textStyle:
                            FlutterFlowTheme.of(context).headlineSmall.override(
                                  fontFamily: 'Glacial Indifference Regular',
                                  color: Colors.white,
                                  fontSize: 16.0,
                                  letterSpacing: 0.0,
                                ),
                        elevation: 3.0,
                        borderSide: BorderSide(
                          color: Colors.transparent,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(40.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
