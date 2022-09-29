import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/sevices.dart';

class NamedIcon extends StatefulWidget {
  final IconData iconData;
  final VoidCallback? onTap;

  const NamedIcon({
    Key? key,
    this.onTap,
    required this.iconData,
  }) : super(key: key);

  @override
  State<NamedIcon> createState() => _NamedIconState();
}

class _NamedIconState extends State<NamedIcon> {
  void funciones() async {
    final siteInfo = Provider.of<InfoSiteService>(context, listen: false);
    final notificacionesProvider =
        Provider.of<NotificacionesService>(context, listen: false);
    await notificacionesProvider
        .getCountNotificaciones(siteInfo.infoSite.userid!);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final notificacion = Provider.of<NotificacionesService>(context);
    final count = notificacion.count;
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        width: 72,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(widget.iconData, size: 30, color: Colors.white),
              ],
            ),
            Positioned(
              top: 5,
              right: 7,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Colors.red),
                alignment: Alignment.center,
                child:
                    // count == 0
                    //     ? const SizedBox(
                    //         width: 15,
                    //         height: 15,
                    //         child: Center(
                    //           child: CircularProgressIndicator(
                    //             color: Colors.white,
                    //             //tamaño del circulo
                    //             strokeWidth: 2,
                    //           ),
                    //         ),
                    //       )
                    //     :
                    Text('$count'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
