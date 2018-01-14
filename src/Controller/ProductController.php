<?php

namespace App\Controller;

use Sensio\Bundle\FrameworkExtraBundle\Configuration\Route;
use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Symfony\Component\HttpFoundation\Response;
use App\Entity\Product;

class ProductController extends Controller
{
    private $entityClass = Product::class;

    /**
     * @Route("/", name="product_list")
     */
    public function productList()
    {
        $products = $this->getDoctrine()->getRepository($this->entityClass)->findAll();

        return $this->render('shop/list.html.twig', [
            'products' => $products,
        ]);
    }

    /**
     * @Route("/{sku}/", name="product_detail")
     */
    public function productDetail($sku)
    {
        $product = $this->getDoctrine()->getRepository($this->entityClass)->findOneBy([
            'sku' => $sku,
        ]);

        if (!$product) {
            throw $this->createNotFoundException();
        }

        return $this->render('shop/product.html.twig', [
            'product' => $product,
        ]);
    }
}
